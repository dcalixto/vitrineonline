class Material < ActiveRecord::Base
  attr_accessible :name




  has_one :product
  has_one :order
  has_one :product_data
  accepts_nested_attributes_for :product, :order,  :product_data


end
