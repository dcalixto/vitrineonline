class Condition < ActiveRecord::Base
  attr_accessible :name, :condition
  has_many :products
end
