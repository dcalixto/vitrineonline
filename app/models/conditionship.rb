class Conditionship < ActiveRecord::Base
  # attr_accessible :title, :body


attr_accessible :product_id, :condition_id, :order_id
  #
  belongs_to :product
  belongs_to :condition
 belongs_to :order



end
