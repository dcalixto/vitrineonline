class RankingsController < ApplicationController
  def index


    @products = Product.find_with_reputation(:votes, :all)
    @vitrines = Vitrine.find_with_reputation(:votes, :all)


    
  end
end
