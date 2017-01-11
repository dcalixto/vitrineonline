class Materialship < ActiveRecord::Base
  # attr_accessible :title, :body

attr_accessible :product_id, :material_id, :order_id
  #
  belongs_to :product
  belongs_to :material
 belongs_to :order



end
