class RankingsController < ApplicationController
  def index
    @products = Product.order(:cached_weighted_average => :desc)
    @vitrines = Vitrine.all
 
  
    @total_feedbacks = Feedback.by_participant(@vitrine.user, Feedback::FROM_BUYERS).count
 

 @average_rating_from_buyers = Feedback.average_rating(@vitrine.user, Feedback::FROM_BUYERS)
  end
end
