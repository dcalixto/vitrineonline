class Proback < ActiveRecord::Base
  attr_accessible :product_id, :buyer_comment,:buyer_rating,:buyer_feedback_date, :user_id


  belongs_to :user

  belongs_to :product
 belongs_to :pdata



#after_commit :proback_product, on: :create




 scope :by_participant, -> { where('user_id = ? and buyer_feedback_date is not null', user.id) }



  scope :rated, -> { where('buyer_rating IS NOT NULL') }




  scope :from_buyers_for_product, ->(product_id) { joins(:product).where(products: { id: product_id }).where.not(buyer_feedback_date: nil) }


  def self.average_rating
    by_participant(user).rated.average(:buyer_rating)
     
  end






  def proback_product

    product.total_feedbacks += 1

    product.average_rating = product.probacks.where('buyer_feedback_date IS NOT NULL').rated.average(:buyer_rating)

    product.save

  end






end
