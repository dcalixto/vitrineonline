class Gender < ActiveRecord::Base
  extend FriendlyId
  friendly_id :gender, use: [:slugged, :history]

  has_many :categories
  has_many :subcategories, through: :categories
  has_many :products 
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :subcategories
  attr_accessible :gender #:categories_attributes, :items_attributes,


end
