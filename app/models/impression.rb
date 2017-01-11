class Impression < ActiveRecord::Base
  attr_accessible :ip_address, :product_id

belongs_to :impressionable, polymorphic: true,counter_cache: :impressions_count

  after_commit ->(impression) {
    ProductRecommender.delay.add_impression(impression)
  }, on: :create

end
