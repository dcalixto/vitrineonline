class CommentsController < ApplicationController

def create
 # @dispute = @dispute.find params[:dispute_id]
  @dispute = @order.dispute
  @comment = @dispute.comments.new params[:comment]
  @comment.user = current_user
  if @comment.save
    redirect_to edit_order_dispute_path

 end
end
end
