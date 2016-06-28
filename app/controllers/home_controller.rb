# encoding: utf-8
require 'product_recommender'
class HomeController < ApplicationController
  # caches_action :index, :layout => false
  
  
  #before_action :tag_cloud



  def index
    @products = Product.all
    @vitrines = Vitrine.all

    @feedbacks = Feedback.includes(:vitrines, :products)
    @orders = Order.includes(:products)

    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)
 
  # @tags = ActsAsTaggableOn::Tag.most_used
 #@tags = Vitrine.tag_list
 
  end




end
