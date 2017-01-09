# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string(255)
#  name       :string(255)
#  gender_id  :integer          not null
#

class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  belongs_to :gender
  has_many :subcategories
  has_many :products
  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :subcategories
  attr_accessible :name, :gender_id


  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id], expires_in: 5.minutes) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  def cached_category
    Category.cached_find(category_id)
  end
end
