class Brandship < ActiveRecord::Base
  # attr_accessible :title, :body

attr_accessible :product_id, :brand_id, :order_id
  #
  belongs_to :product
  belongs_to :brand
 belongs_to :order




end
