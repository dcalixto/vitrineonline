class CommentsController < ApplicationController

def create
  @dispute = @dispute.find params[:dispute_id]
  @comment = @dispute.comments.new params[:comment]
  if @comment.save
    redirect_to edit_order_dispute_path

 end
end
end
