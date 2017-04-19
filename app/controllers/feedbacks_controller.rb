# encoding: utf-8
class FeedbacksController < ApplicationController
  before_filter :authorize, :awaiting_count
  skip_after_filter :flash_to_headers

  def awaiting_count
    @awaiting_feedback_count = Order.awaiting_feedback(current_user).count
  end

  def completed
    @user = current_user
    # @feedbacks = Feedback.by_participant(@user, params[:view]).paginate(:page => params[:page], :per_page => 22)
    @q = Feedback.by_participant(@user, params[:view]).ransack(params[:q])
    @feedbacks = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)
    @average_rating_from_buyers = Feedback.average_rating(@user, Feedback::FROM_BUYERS)
    @average_rating_from_sellers = Feedback.average_rating(@user, Feedback::FROM_SELLERS)
  end

  def awaiting
    @awaiting_feedbacks_orders = Order.awaiting_feedback(current_user).paginate(page: params[:page], per_page: 22)
    @feedback = Feedback.new
  end

  def create
    @order = Order.find_by_id(params[:order_id])
    feedback = @order.feedback.nil? ? Feedback.new : @order.feedback
    feedback.attributes = params[:feedback]
    feedback.user = @order.buyer
    feedback.vitrine = @order.seller
    feedback.buyer_name = @order.buyer.first_name
    feedback.seller_name = @order.seller.name

    if feedback.save
      flash[:success] = 'Obrigado'
      @order.feedback = feedback
      @order.save

    
if  feedback.user = @order.buyer
   proback = Proback.new
    proback.product_id = @order.product_id
    proback.pdata_id = @order.product_id
    proback.feedback_id = feedback.id
    proback.user_id = feedback.user_id
    proback.buyer_comment  = feedback.buyer_comment
    proback.buyer_rating   = feedback.buyer_rating
    proback.buyer_feedback_date   = feedback.buyer_feedback_date
    proback.save
end


    else
      flash[:error] = 'Erro'
    end
    



    redirect_to action: :awaiting
  end
end
