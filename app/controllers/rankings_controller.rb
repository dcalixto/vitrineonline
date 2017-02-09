class RankingsController < ApplicationController
  def index
    @products = Product.order(:cached_weighted_average => :desc)
    @vitrines = Vitrine.all
  end
end
