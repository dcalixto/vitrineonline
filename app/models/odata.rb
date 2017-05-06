class Odata < ActiveRecord::Base
  # attr_accessible :title, :body

belongs_to :order
belongs_to :pdata
belongs_to :feedback

  attr_accessible :cart_id, :product_id, :purchased_at, :quantity,
    :buyer_id, :quantity, :seller_id, :shipping_cost, :shipping_method, 
    :status,  :color_id, :size_id,  :brand_id, :material_id,:condition_id, :track_number



end
