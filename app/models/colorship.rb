class Colorship < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :product_id, :size_id
  #
  belongs_to :product
  belongs_to :color
end
