class DisputesController < ApplicationController

  before_filter :set_order

  def new
    if current_user.address.blank?
      redirect_to edit_user_path

      flash[:error] = 'Antes de prosseguir por favor, preencha o seu endereço'
    else
      @dispute = Dispute.new

@comment = @dispute.comments.build#(params[:comment])
    @comment.user = current_user
   @image = @dispute.images.build
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
      dispute.buyer_email = @order.buyer.email
      dispute.seller_email = @order.seller.email

      dispute.transaction_id = @order.transaction.transaction_id
      dispute.status = !dispute.status
    

             if dispute.save

#  @comment = @dispute.comments.build(params[:comment])
   # @comment.user = current_use
   

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
    @comments = @dispute.comments.all
    
@comment = @dispute.comments.build(params[:comment])
    @comment.user = current_user
@image = @dispute.images.build(params[:image])

# params[:images]['file'].each do |a|
 #         @image = @dispute.images.create!(:file => a)
   #    end


  end

  def edit
    @dispute = @order.dispute
    #@comment = @dispute.comments.new
    @comments = @dispute.comments.all
  end


  def finish


    @dispute = @order.dispute
        dispute.status = !dispute.status
    if dispute.save

      DisputeMailer.dispute_finish(@dispute).deliver

      redirect_to orders_path




      flash[:success] = 'Reclamação terminada'

    else
      render :show
    end
  end



 def comment
    dispute = Dispute.find(params[:dispute_id])
    dispute.comments.create(:comment => params[:comment], :user => current_user)
    render :nothing => true
  end

  def comments
    dispute = Dispute.find(params[:dispute_id])
    render :partial => 'comments', :locals => {dispute: dispute}
  end



  def update
    @dispute = @order.dispute
    if @dispute.update_attributes(params[:dispute])
      redirect_to order_dispute_path_path#(@order, @dispute)
      DisputeMailer.dispute_update(@dispute).deliver
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





