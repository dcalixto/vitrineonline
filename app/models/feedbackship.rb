class Feedbackship < ActiveRecord::Base
  attr_accessible :feedback_id, :order_id, :product_id

  belongs_to :order
  belongs_to :product
 belongs_to :feedback

end
