# encoding: utf-8
class HomeController < ApplicationController
  # caches_action :index, :layout => false
  def index
    # @q = Product.ransack(params[:q])
    # @products = @q.result(:distinct => true).paginate(:per_page => 2, :page => params[:page]).order('created_at DESC')
    @products = Product.all
    @vitrines = Vitrine.all
  end
end
