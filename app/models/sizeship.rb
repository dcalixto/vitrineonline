class Sizeship < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :product_id, :size_id, :order_id, :product_data_id

  #
  belongs_to :product
  belongs_to :size
 belongs_to :order
belongs_to :product_data


  validates_associated :product

end
