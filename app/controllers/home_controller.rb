# encoding: utf-8
require 'product_recommender'
class HomeController < ApplicationController
  # caches_action :index, :layout => false
  def index
    @products = Product.all
    @vitrines = Vitrine.all

    @feedbacks = Feedback.includes(:vitrines, :products)
    @orders = Order.includes(:products)

    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)
  end




  def tags

    @tags = ActsAsTaggableOn::Tag.where('tags.name LIKE ?', "%#{params[:q]}%")
    respond_to do |format|
      format.json { render json: @tags.collect { |t| { id: t.name, name: t.name } } }
    end

end
end
