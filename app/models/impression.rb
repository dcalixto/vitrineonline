class Impression < ActiveRecord::Base
  attr_accessible :ip_address, :product_id
  belongs_to :product
end
