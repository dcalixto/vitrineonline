class Sizeship < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :product_id, :size_id, :order_id
  #
  belongs_to :product
  belongs_to :size
 belongs_to :order

end
