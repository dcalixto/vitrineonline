class Image < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :ifoto, :product_id, :product_data_id
  belongs_to :product
  belongs_to :product_data
  mount_uploader :ifoto, FotoUploader
end
