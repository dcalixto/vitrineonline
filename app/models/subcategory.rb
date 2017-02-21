class Subcategory < ActiveRecord::Base
  # attr_accessible :title, :body

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  belongs_to :category
  has_many :products
  accepts_nested_attributes_for :products
  attr_accessible :products_attributes, :name,  :slug,  :category_id


  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id], expires_in: 5.minutes) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  def cached_subcategory
    Subcategory.cached_find(subcategory_id)
  end

after_commit :clear_cache

  def clear_cache
    $redis.del "subcategories"
  end


end
