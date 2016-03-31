class Color < ActiveRecord::Base
  attr_accessible :name, :hex
  has_many :orders
  #has_and_belongs_to_many :products
  has_many :colorship
  has_many :products, :through => :colorship
  #accepts_nested_attributes_for :orders, :products


end
