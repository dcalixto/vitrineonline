class Brand < ActiveRecord::Base
  attr_accessible :name
  has_many :products
has_one :order, as: :orderable

end
