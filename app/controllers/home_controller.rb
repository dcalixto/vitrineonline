# encoding: utf-8
require 'product_recommender'
class HomeController < ApplicationController
  # caches_action :index, :layout => false


  def index
    @vitrines = Vitrine.all

    @feedbacks = Feedback.includes(:vitrines, :products)
    @orders = Order.includes(:products)

    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)

    if params[:tag]

      @products = Product.tagged_with(params[:tag]).order('DESC').limit(22)
    else
      @products = Product.all
    end
  end




end
