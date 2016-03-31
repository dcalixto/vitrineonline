class Image < ActiveRecord::Base
  # attr_accessible :title, :body

 attr_accessible :foto
  belongs_to :product

    mount_uploader :foto, FotoUploader

end
