class Material < ActiveRecord::Base
  attr_accessible :name



 has_many :materialships
  has_many :products, :through => :materialships
  has_many :orders, :through => :materialships

  accepts_nested_attributes_for :products, :orders


end
