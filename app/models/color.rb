class Color < ActiveRecord::Base
  attr_accessible :name, :hex
  has_many :orders

  has_and_belongs_to_many :products


  accepts_nested_attributes_for :orders, :products





end
