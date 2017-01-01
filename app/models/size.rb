class Size < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :size
 # has_many :orders 
  has_many :sizeship
  has_many :products, :through => :sizeship

has_many :orders, as: :oderable


end
