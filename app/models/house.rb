class House < ActiveRecord::Base
  
attr_accessible :name



has_many :products

belongs_to :block


end
