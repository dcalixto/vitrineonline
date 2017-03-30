# encoding: utf-8
require 'product_recommender'
class HomeController < ApplicationController
  # caches_action :index, :layout => false
  include ProductsHelper 
 include VitrinesHelper 
 
  


 
 def index


feedbacks = Feedback.scoped

   @vitrines = Vitrine.all

 
    @orders = Order.includes(:products)

    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :orders)
    @suggestions = Product.unscoped.for_ids_with_order(ids)

    if params[:tag]


      @products = Product.includes(:images,:vitrine).tagged_with(params[:tag]).order('DESC').limit(22)
# @average_rating  = Product.joins(:prodbacks).where(:probacks => ('buyer_feedback_date is not null').rated.average(:buyer_rating) || 0 )

#@average_rating = Product.joins(:prodbacks).where.not(prodbacks: {buyer_feedback_date: nil}).rated.average(:buyer_rating) || 0
# controller
products_ids = @products.collect(&:id)
#@average_rating  = 
#  feedbacks.where(product_id: products_ids).
 #   where('buyer_feedback_date is not null').rated.(Feedback::FROM_BUYERS).
  #  group(:product_id).
  #  average(:buyer_rating) || 0


@average_rating = feedbacks.where(product_id: products_ids).where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating) || 0







  @total_feedbacks   = 
  feedbacks.where(product_id: products_ids).
    where('buyer_feedback_date is not null').count


    else
  
      @products = Product.includes(:images,:vitrine).all
   
#@average_rating  = Product.joins(:prodbacks).where(:prodbacks => ('buyer_feedback_date is not null').rated.average(:buyer_rating) || 0 )

#@average_rating = Product.joins(:prodbacks).where.not(prodbacks: {buyer_feedback_date: nil}).rated.average(:buyer_rating) || 0
    
   



# controller
products_ids = @products.collect(&:id)


@average_rating = feedbacks.where(product_id: products_ids).where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating) || 0





    @total_feedbacks   = 
  feedbacks.where(product_id: products_ids).
    where('buyer_feedback_date is not null').count
    
  end




 end

