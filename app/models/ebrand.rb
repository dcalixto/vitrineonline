class Ebrand < ActiveRecord::Base
  attr_accessible :name

  has_many :eletronics

end
