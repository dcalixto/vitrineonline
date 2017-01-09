class Marketing < ActiveRecord::Base


  attr_accessible :vitrine_id
  belongs_to :vitrine
  attr_accessible :url, :banner, :facebook,:twitter,:youtube,:pinterest,:instagram

  mount_uploader :banner, BannerUploader

end
