class Color < ActiveRecord::Base
  attr_accessible :name, :hex
  
 
  has_many :colorships
  has_many :products, :through => :colorships
  has_many :orders, :through => :colorships
  accepts_nested_attributes_for :products, :orders



end
