class Feedback < ActiveRecord::Base

  belongs_to :user
  belongs_to :vitrine
  has_one :order
 has_one :product, through: :order


#validates_presence_of  :buyer_comment, :seller_comment, nil: false  # this cause a bug - buyer can't post feedback


  FROM_BUYERS = 'from_buyers'
  FROM_SELLERS = 'from_sellers'

  NOT_RATED = 0

  self.per_page = 25

  attr_accessible :buyer_comment, :seller_comment, :buyer_rating, :seller_rating, :buyer_feedback_date, :seller_feedback_date

  scope :by_participant, lambda { |user, from_who|
    case from_who
    when FROM_BUYERS
      where('vitrine_id = ? and buyer_feedback_date is not null', user.vitrine ? user.vitrine.id : 0).order('buyer_feedback_date desc')
    when FROM_SELLERS
      where('user_id = ? and seller_feedback_date is not null', user.id).order('seller_feedback_date desc')
    else
      where('(user_id = ? and seller_feedback_date is not null) or (vitrine_id = ? and buyer_feedback_date is not null)', user.id, user.vitrine ? user.vitrine.id : 0).order('updated_at desc')
      end
  }

  scope :rated, ->(from_who) { where("#{from_who == Feedback::FROM_BUYERS ? 'buyer_rating' : 'seller_rating'} <> ?", Feedback::NOT_RATED) }

  def self.average_rating(user, from_who)
    case from_who
    when FROM_BUYERS
      by_participant(user, from_who).rated(from_who).average(:buyer_rating)
    when FROM_SELLERS
      by_participant(user, from_who).rated(from_who).average(:seller_rating)
    end
  end
end
