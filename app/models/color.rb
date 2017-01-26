class Color < ActiveRecord::Base
  attr_accessible :name, :hex


  has_many :colorships
  has_one :colorship
 
  has_many :products, :through => :colorships
  has_one :order, :through => :colorship
  has_many :product_datas, :through => :colorships
  accepts_nested_attributes_for :products, :order








 






end
