class RankingsController < ApplicationController
  def index
    @products = Product.order(:cached_weighted_average => :desc)
    @vitrines = Vitrine.get_likes(:vote_scope => 'rank').size
  end
end
