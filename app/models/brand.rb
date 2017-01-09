class Brand < ActiveRecord::Base
  attr_accessible :name
  has_many :products
has_many :orders, as: :orderable

end
