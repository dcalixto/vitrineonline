class Color < ActiveRecord::Base
 attr_accessible :name, :product_id, :order_id, :product_data_id


  has_many :colorships
  has_one :colorship
 
  has_many :products, :through => :colorships
  has_one :order, :through => :colorship

  accepts_nested_attributes_for :products, :order








 






end
