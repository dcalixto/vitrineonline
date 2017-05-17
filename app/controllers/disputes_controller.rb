class DisputesController < ApplicationController

  def new

 # @order = Order.find_by_id(params[:order_id])
@order = Order.find params[:order_id]
    if current_user.address.blank?
      redirect_to edit_user_path

      flash[:error] = 'Antes de prosseguir por favor, preencha o seu endereço'
    else
      @dispute = Dispute.new



    end
  end 



def create

@order = Order.find params[:order_id]

  if   current_user == @order.buyer


    dispute = @order.dispute.nil? ? Dispute.new : @order.dispute
    dispute.attributes = params[:dispute]
    dispute.user = @order.buyer
    dispute.vitrine = @order.seller
    dispute.buyer_name = @order.buyer_name
    dispute.seller_name = @order.seller_name
    dispute.trasanction_id = @order.order.transaction.transaction_id


    if dispute.save
      flash[:success] = 'Contestação Criada'




    end





  else
    flash[:error] = 'Erro'
  end




  redirect_to :back
end
end





