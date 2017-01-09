class Gender < ActiveRecord::Base
  extend FriendlyId
  friendly_id :gender, use: [:slugged, :history]

  has_many :categories
  has_many :subcategories, through: :categories
  has_many :products

 
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :subcategories
  attr_accessible :gender, :categories_attributes, :subcategories_attributes


  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([gender, id], expires_in: 5.minutes) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.gender, id])
  end

  def cached_categiry
    Gender.cached_find(gender_id)
  end

end
