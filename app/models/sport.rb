class Sport < ActiveRecord::Base
   attr_accessible :category


has_many :products

belongs_to :block



end
