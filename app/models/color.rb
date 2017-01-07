class Color < ActiveRecord::Base
  attr_accessible :name, :hex
  has_many :orders, as: :orderable

  #has_and_belongs_to_many :products
  has_many :colorships
  has_many :products, :through => :colorships
  #accepts_nested_attributes_for :orders, :products


 
end
