# encoding: utf-8
require 'product_recommender'
class HomeController < ApplicationController
  # caches_action :index, :layout => false
  include ProductsHelper 
 include VitrinesHelper 
  def index
    @vitrines = Vitrine.all
  # AVERAGE BUYER RATING
  def average_rating
    prodbacks.where('buyer_feedback_date is not null').rated.average(:buyer_rating) || 0
  end




#@total_feedbacks = Product.joins.(:orders).where('orders = ?',@orders).where('buyer_feedback_date is not null').count
#from_nil = Picture.where(imageable: nil).where_values.reduce(:and)


  # @total_feedbacks = Product.joins(:feedbacks).where('feedbacks = ?', @feedbacks).where('buyer_feedback_date is not null').count


#@average_rating = Product.joins(:feedbacks).where('feedbacks = ?', @feedbacks).where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating)


 # @total_feedbacks = Feedback.by_participant(@products.feedbacks, Feedback::FROM_BUYERS).count
     
 #   @average_rating = Feedback.average_rating(@vitrine.user.products, Feedback::FROM_BUYERS)
  
#feedbacks = Feedback.all

 
    @orders = Order.includes(:products)

    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :orders)
    @suggestions = Product.unscoped.for_ids_with_order(ids)

    if params[:tag]
   #   @average_customer_rating = Product.where('buyer_feedback_date is not null').rated(Product::FROM_BUYERS).average(:buyer_rating) || 0

      
      #  @average_rating  = Product.prodbacks.average_rating
      
      
     # @total_feedbacks  = Product.where('buyer_feedback_date is not null').count
# @total_feedbacks = Product.prodbacks.by_participant.count


@total_feedbacks = Product.average_rating.count


    @average_rating  = Product.average_rating



     
 #   @average_rating = Feedback.average_rating(@vitrine.user.products, Feedback::FROM_BUYERS)



      @products = Product.includes(:images,:vitrine).tagged_with(params[:tag]).order('DESC').limit(22)
    else
     
      @products = Product.includes(:images,:vitrine).all
   
     # @average_customer_rating = Product.where('buyer_feedback_date is not null').rated(Product::FROM_BUYERS).average(:buyer_rating) || 0
# @average_rating  = Product.prodbacks.average_rating#(FROM_BUYERS)


      
    #  @average_customer_rating = feedbacks.where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating) || 0
# @total_feedbacks  = Product.where('buyer_feedback_date is not null').count

 # @total_feedbacks = Product.prodbacks.by_participant.count



@total_feedbacks = Product.average_rating.count


    @average_rating  = Product.average_rating


    end
 
  
  
  end




end
