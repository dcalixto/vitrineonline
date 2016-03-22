class Banner < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :img
  # belongs_to :boutique
  belongs_to :vitrine

    mount_uploader :img, ImgUploader
end
