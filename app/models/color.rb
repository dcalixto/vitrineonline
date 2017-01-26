class Color < ActiveRecord::Base
  attr_accessible :name, :hex


  has_many :colorships
  has_one :colorship
   has_one :product_data
  has_many :products, :through => :colorships
  has_one :order, :through => :colorship
  accepts_nested_attributes_for :products, :order








 






end
