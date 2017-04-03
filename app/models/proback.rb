class Proback < ActiveRecord::Base
   attr_accessible :product_id, :buyer_comment,:buyer_rating,:buyer_feedback_date, :user_id





belongs_to :product

end
