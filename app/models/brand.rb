class Brand < ActiveRecord::Base
  attr_accessible :name
  has_many :brandships
  has_many :products, :through => :brandships
  has_many :orders, :through => :brandships

  accepts_nested_attributes_for :products, :orders



end
