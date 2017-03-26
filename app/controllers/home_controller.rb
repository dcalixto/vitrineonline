# encoding: utf-8
require 'product_recommender'
class HomeController < ApplicationController
  # caches_action :index, :layout => false
  include ProductsHelper 
 include VitrinesHelper 
  def index
    @vitrines = Vitrine.all

   
#@total_feedbacks = Product.joins.(:orders).where('orders = ?',@orders).where('buyer_feedback_date is not null').count
#from_nil = Picture.where(imageable: nil).where_values.reduce(:and)


       #
#@total_feedbacks = Feedback.joins(:products).where('products = ?', @products).where('buyer_feedback_date is not null').count


#@average_rating = Feedback.joins(:products).where('products = ?', @products).where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating)



#  @total_feedbacks = Feedback.by_participant(@vitrine.user.products, Feedback::FROM_BUYERS).count
     
 #   @average_rating = Feedback.average_rating(@vitrine.user.products, Feedback::FROM_BUYERS)
  



    @orders = Order.includes(:products)

    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :orders)
    @suggestions = Product.unscoped.for_ids_with_order(ids)

    if params[:tag]

      @products = Product.includes(:images,:vitrine).tagged_with(params[:tag]).order('DESC').limit(22)
    else
      @products = Product.includes(:images,:vitrine).all
    end
 
  
  
  end




end
