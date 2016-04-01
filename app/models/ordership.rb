class Ordership < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :policy_id, :vitrine_id,:product_id, :feedback_id
  #
  belongs_to :product
  belongs_to :order
  belongs_to :feedback
  belongs_to :vitrine


end
