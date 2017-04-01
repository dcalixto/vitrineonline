# encoding: utf-8
require 'product_recommender'
class HomeController < ApplicationController
  # caches_action :index, :layout => false
  include ProductsHelper 
  include VitrinesHelper 

  def index


    @vitrines = Vitrine.all

    @orders = Order.includes(:products)

    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :orders)
    @suggestions = Product.unscoped.for_ids_with_order(ids)

    if params[:tag]


      @products = Product.includes(:images,:vitrine).tagged_with(params[:tag]).order('DESC').limit(22)
     
   
    
    
@average_rating_from_buyers = {}
@total_feedbacks = {}

@products.each do |product|
feedbacks = Feedback.from_buyers_for_product(product.id)
@total_feedbacks[product.id] = feedbacks.size
@average_rating_from_buyers[product.id] = feedbacks.rated(Feedback::FROM_BUYERS).average(:buyer_rating)
end
    
    else

      @products = Product.includes(:images,:vitrine).all
   
    
    
    @average_rating_from_buyers = {}
@total_feedbacks = {}

@products.each do |product|
feedbacks = Feedback.from_buyers_for_product(product.id)
@total_feedbacks[product.id] = feedbacks.size
@average_rating_from_buyers[product.id] = feedbacks.rated(Feedback::FROM_BUYERS).average(:buyer_rating)
end

    
    
    
    end


  end
end
