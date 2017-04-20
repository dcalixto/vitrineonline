class Feedback < ActiveRecord::Base

  belongs_to :user
  belongs_to :vitrine
  has_one :order
  has_one :product, through: :order#,  inverse_of: :feedback


  #after_commit :feedback_product, on: :create
#  after_create :feedback_product

  before_save :doproback, :if =>  :from_buyers
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

  scope :from_buyers_for_product, ->(product_id) { joins(:product).where(products: { id: product_id }).where.not(buyer_feedback_date: nil) }

  def from_buyers
    order = Order.find_by_id(attributes['order_id'])
    user = User.find_by_id(attributes['user_id'])
    product = Product.find_by_id(attributes['product_id'])


  end


  def self.average_rating(user, from_who)
    case from_who
    when FROM_BUYERS
      by_participant(user, from_who).rated(from_who).average(:buyer_rating)
    when FROM_SELLERS
      by_participant(user, from_who).rated(from_who).average(:seller_rating)
    end
  end



  def feedback_product

    order = Order.find_by_id(attributes['order_id'])
    feedback = Feedback.find_by_id(attributes['id'])
    order = feedback.order
    product = order.product_id
    product.total_feedbacks += 1
    product.average_rating = product.feedbacks.where('buyer_feedback_date IS NOT NULL').rated(Feedback::FROM_BUYERS).average(:buyer_rating)

    product.save


  end





  def doproback
  #  order = Order.find_by_id(attributes['order_id'])
    proback = Proback.new
    order = Order.find_by_id(attributes['order_id'])

    proback.product_id = order.product_id
    proback.pdata_id = order.product_id
    proback.feedback_id = feedback.id
    proback.user_id = feedback.user_id
    proback.buyer_comment  = feedback.buyer_comment
    proback.buyer_rating   = feedback.buyer_rating
    proback.buyer_feedback_date   = feedback.buyer_feedback_date
    proback.save


  end
end
