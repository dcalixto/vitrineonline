class Condition < ActiveRecord::Base
  attr_accessible :name, :condition
  has_many :products



 has_many :conditionships
  has_many :products, :through => :conditionships
  has_many :orders, :through => :conditionships

  accepts_nested_attributes_for :products, :orders


end
