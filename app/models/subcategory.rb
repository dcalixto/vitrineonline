class Subcategory < ActiveRecord::Base
  # attr_accessible :title, :body

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  belongs_to :category
  has_many :products
  accepts_nested_attributes_for :products
  attr_accessible :products_attributes, :name,  :category_id





end
