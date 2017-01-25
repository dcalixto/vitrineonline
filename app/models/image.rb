class Image < ActiveRecord::Base
  # attr_accessible :title, :body
#include IdentityCache::WithoutPrimaryIndex
 attr_accessible :ifoto
  belongs_to :product
belongs_to :product_data
    mount_uploader :ifoto, FotoUploader
end
