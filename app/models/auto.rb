class Auto < ActiveRecord::Base
  # attr_accessible :title, :body


attr_accessible :item



has_many :products

belongs_to :block

end
