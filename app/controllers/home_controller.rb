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
  
    
    
    
    
      @total_feedbacks = Proback.joins(:product).where('products.id = ?', @product.id).where('buyer_feedback_date is not null').count
    @average_rating = Proback.joins(:product).where('products.id = ?', @product.id).where('buyer_feedback_date is not null').rated.average(:buyer_rating)


    
    
    else
  
      @products = Product.includes(:images,:vitrine).all
   


  
  end



 end
end
