class Post < ActiveRecord::Base
  acts_as_commentable
  belongs_to :user
  attr_accessible :text, :image
  mount_uploader :image, ImageUploader
  # validates_presence_of :text,  :on => :create
end
