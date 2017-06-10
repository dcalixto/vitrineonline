class Eletronic < ActiveRecord::Base
   
 attr_accessible :item



has_many :products

belongs_to :ebrand

end
