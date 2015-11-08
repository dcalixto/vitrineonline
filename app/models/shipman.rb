class Shipman < ActiveRecord::Base
  attr_accessible :policy_id, :shipping_id
  #
  belongs_to :policy
  belongs_to :shipping
end
