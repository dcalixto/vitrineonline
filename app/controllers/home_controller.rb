# encoding: utf-8
class HomeController < ApplicationController
  # caches_action :index, :layout => false
  def index
    @products = Product.all
    @vitrines = Vitrine.all
   # @similiar_products = ProductRecommender.instance.similarities_for("product-1")
  end
end
