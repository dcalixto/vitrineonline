class Condition < ActiveRecord::Base
  attr_accessible :name, :condition
  has_many :products
  has_one :order
  has_one :product_data
  accepts_nested_attributes_for :products, :order, :product_data


end
