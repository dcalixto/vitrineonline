class CommentsController < ApplicationController

def create
 # @dispute = @dispute.find params[:dispute_id]
    @order = Order.find(params[:order_id])
  @dispute = @order.dispute
 # @comment = @dispute.comments.new params[:comment]
  ##@comment.user = current_user

#@comment = @dispute.comments.build(params[:comment])
   # @comment.user = current_user


  @comment =  @dispute.comments.create(:comment => params[:comment], :user => current_user)
@comment.user = current_user

  if @comment.save
   redirect_to order_dispute_path
  end
end
end
