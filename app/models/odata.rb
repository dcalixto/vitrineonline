class Odata < ActiveRecord::Base
  # attr_accessible :title, :body
 STATUSES = %w(paid sent).freeze

  belongs_to :seller, foreign_key: 'seller_id', class_name: 'Vitrine'
  belongs_to :buyer, foreign_key: 'buyer_id', class_name: 'User'

belongs_to :order
belongs_to :pdata
belongs_to :feedback

  attr_accessible :cart_id, :product_id, :purchased_at, :quantity,
    :buyer_id, :quantity, :seller_id, :shipping_cost, :shipping_method, 
    :status,  :color_id, :size_id,  :brand_id, :material_id,:condition_id, :track_number

  def total_price
    pdata.price * quantity
  end

  STATUSES.each do |method|
    define_method "#{method}?" do
      status == method
    end
  end

  def self.statuses
    STATUSES
  end



end
