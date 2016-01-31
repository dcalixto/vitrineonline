class Impression < ActiveRecord::Base
  attr_accessible :ip_address, :product_id
  belongs_to :product

  after_commit ->(impression) {
    ProductRecommender.delay.add_impression(impression)
  }, on: :create

end
