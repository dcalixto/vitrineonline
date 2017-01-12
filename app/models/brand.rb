class Brand < ActiveRecord::Base
  attr_accessible :name
   has_one :product
has_one :order
  accepts_nested_attributes_for :product, :order



end
