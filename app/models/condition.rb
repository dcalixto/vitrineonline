class Condition < ActiveRecord::Base
  attr_accessible :name, :condition
  has_many :products
has_many :orders, as: :oderable

end
