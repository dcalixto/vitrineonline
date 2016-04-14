class Image < ActiveRecord::Base
  # attr_accessible :title, :body

 attr_accessible :ifoto
  belongs_to :product

    mount_uploader :ifoto, FotoUploader
 default_scope order('position ASC')
end
