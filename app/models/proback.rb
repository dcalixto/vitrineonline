class Proback < ActiveRecord::Base
   attr_accessible :product_id, :buyer_comment,:buyer_rating,:buyer_feedback_date, :user_id



belongs_to :user

belongs_to :product






  FROM_BUYERS = 'from_buyers'
  FROM_SELLERS = 'from_sellers'

  NOT_RATED = 0


  
  scope :by_participant, lambda { |user, from_who|
    case from_who
    when FROM_BUYERS
      where('user_id = ? and buyer_feedback_date is not null', user ? user.id : 0).order('buyer_feedback_date desc')
         end
  }

  scope :rated, ->(from_who) { where("#{from_who == Feedback::FROM_BUYERS ? 'buyer_rating' : 'seller_rating'} <> ?", Feedback::NOT_RATED) }

  scope :from_buyers_for_product, ->(product_id) { joins(:product).where(products: { id: product_id }).where.not(buyer_feedback_date: nil) }


  def self.average_rating(user, from_who)
    case from_who
    when FROM_BUYERS
      by_participant(user, from_who).rated(from_who).average(:buyer_rating)
      end
  end








end
