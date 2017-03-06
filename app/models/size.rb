class Size < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :size, :product_id, :order_id
  has_many :sizeships
  has_many :products, :through => :sizeships
  has_many :orders, :through => :sizeships
  accepts_nested_attributes_for :products, :orders
 




end
