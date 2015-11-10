class Size < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :size
  has_many :orders # , :through => :sizeships

  #has_and_belongs_to_many :products

  has_many :sizeship
  has_many :products, :through => :sizeship
end
