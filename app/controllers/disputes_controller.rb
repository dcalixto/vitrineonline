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
      @proof = @dispute.proofs.build
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
      #dispute.status = !dispute.status
     
@order = params[:dispute_status] == "1"
 
      if dispute.save

        #  @order.update_attributes(:dispute_status => true)

        
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
    @proof = @dispute.proofs.build(params[:proof])

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
      @dispute.status  == "closed"
   @dispute.status = Dispute.statuses[1]
    if @dispute.save#(:validate=> false)

      DisputeMailer.dispute_finish(@dispute).deliver

      redirect_to closed_order_dispute_path




      flash[:success] = 'Reclamação terminada'

    else
      render :show
    end
  end








def closed
  @dispute = @order.dispute

end




  def update
    @dispute = @order.dispute


    respond_to do |format|
      format.html do

        if @dispute.update_attributes(params[:dispute])
          #params[:proofs]['file'].each do |a|
          #     @proof = @dispute.proofs.create!(:file => a)
          #  end
          redirect_to order_dispute_path#(@order, @dispute)
          DisputeMailer.dispute_update(@dispute).deliver
          flash[:success] = 'Reclamação atualizada'

        else
          render :show
        end
      end
      format.json do

        if @dispute.update_attributes(params[:dispute])
          params[:proofs]['file'].each do |a|
            @proof = @dispute.proofs.create!(:file => a)
          end

        end
        render :nothing => true

      end
    end
  end





  def upload
    @dispute = @order.dispute
    respond_to do |format|
      format.json do
        if @dispute.update_attributes(params[:dispute])
          params[:proofs]['file'].each do |a|
            @proof = @dispute.proofs.create!(:file => a)
          end
        end
        render :nothing => true
      end

    end
  end


  private

  def set_order
    @order = Order.find params[:order_id]
  end

end





