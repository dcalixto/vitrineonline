class Image < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :ifoto, :product_id, :pdata_id,:file
  belongs_to :product,  inverse_of: :images
  belongs_to :pdata, inverse_of: :images


 belongs_to :dispute, inverse_of: :images

  mount_uploader :ifoto, FotoUploader

  mount_uploader :file, FileUploader

end
