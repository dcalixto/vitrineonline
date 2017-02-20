class Image < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :ifoto, :product_id, :product_data_id
  belongs_to :product,  inverse_of: :images
  belongs_to :product_data, inverse_of: :images
  mount_uploader :ifoto, FotoUploader
end
