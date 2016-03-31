class Banner < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :img
  belongs_to :vitrine

    mount_uploader :img, ImgUploader
end
