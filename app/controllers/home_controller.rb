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
      products_ids = @products.collect(&:id)


      
@average_rating= Feedback.joins(:product).where('products.id IN (?)', products_ids).where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating)





      @total_feedbacks  =Feedback.joins(:product).where('products.id IN (?)', products_ids).where('buyer_feedback_date is not null').count


    else

      @products = Product.includes(:images,:vitrine).all

      # controller
      products_ids = @products.collect(&:id)


   @average_rating= Feedback.joins(:product).where('products.id IN (?)', products_ids).where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating)

      @total_feedbacks  =Feedback.joins(:product).where('products.id IN (?)', products_ids).where('buyer_feedback_date is not null').count

    end


  end
end
