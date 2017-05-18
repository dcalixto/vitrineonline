class Image < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :ifoto, :product_id, :pdata_id
  belongs_to :product,  inverse_of: :images
  belongs_to :pdata, inverse_of: :images

 belongs_to :dispute, inverse_of: :images


  mount_uploader :ifoto, FotoUploader
end
