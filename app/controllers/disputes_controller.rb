class DisputesController < ApplicationController

before_filter :set_order

  def new
    if current_user.address.blank?
      redirect_to edit_user_path

      flash[:error] = 'Antes de prosseguir por favor, preencha o seu endereço'
    else
      @dispute = Dispute.new



    end
  end 



def create

  if   current_user == @order.buyer

 

    dispute = @order.dispute.nil? ? Dispute.new : @order.dispute
    dispute.attributes = params[:dispute]
    dispute.order = @order
    dispute.buyer = @order.buyer
    dispute.seller = @order.seller
    dispute.buyer_name = @order.buyer_name
    dispute.seller_name = @order.seller_name
    dispute.transaction_id = @order.transaction.transaction_id

    if params[:status] == 'Open'
      dispute.status = dispute.statuses[0]
    end

    if dispute.save

       redirect_to order_dispute_path(@order, @dispute)
      flash[:success] = 'Reclamação Criada'

  else
    flash[:error] = 'Erro'
  redirect_to :back
end

  end
end



def show
  @dispute = @order.dispute
end




def update
   @dispute = @order.dispute
    if @dispute.update_attributes(params[:dispute])
      redirect_to :back
      flash[:success] = 'Reclamação atualizada'
    else
      render :show
    end
  end



private

def set_order
@order = Order.find params[:order_id]
end

end





