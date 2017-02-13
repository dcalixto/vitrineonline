# encoding: utf-8
require 'product_recommender'
class HomeController < ApplicationController
  # caches_action :index, :layout => false


  def index
    @vitrines = Vitrine.all
  @total_feedbacks = Feedback.joins(:product).where(:products).where('buyer_feedback_date is not null').count
  
  @average_rating_from_buyers = Feedback.joins(:product).where(:products).where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating)


   @feedbacks = Feedback.includes(:vitrines, :products).where('buyer_feedback_date is not null').count

    @orders = Order.includes(:products)

    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :orders)
    @suggestions = Product.unscoped.for_ids_with_order(ids)

    if params[:tag]

      @products = Product.tagged_with(params[:tag]).order('DESC').limit(22)
    else
      @products = Product.all
    end
  end




end
