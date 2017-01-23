class Impression < ActiveRecord::Base
  attr_accessible :ip_address, :product_id

belongs_to :impressionable, polymorphic: true,counter_cache: :impressions_count
  scope :stats, ->(date_range) { select('DATE(created_at) as day, count(*) as count').group('DATE(created_at)').where(created_at: date_range) }


  after_commit ->(impression) {
    ProductRecommender.add_impression(impression)
  }, on: :create




 end
