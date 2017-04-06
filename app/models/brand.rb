class Brand < ActiveRecord::Base
  attr_accessible :name
  has_many :products
  has_one :order
  belongs_to :vitrine
  has_one :product_data
  accepts_nested_attributes_for :products, :order, :product_data

end
