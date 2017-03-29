class Prodback < ActiveRecord::Base
  # attr_accessible :title, :body

#belongs_to :product

 attr_accessible :buyer_comment,  :buyer_rating,:buyer_feedback_date,:product_id



scope :by_participant, -> {  where('buyer_feedback_date is not null').order('buyer_feedback_date desc') }


scope :rated, -> {  where('buyer_rating is not null') }


  def self.average_rating
    by_participant.rated.average(:buyer_rating) || 0

  end



end
