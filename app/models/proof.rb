class Proof < ActiveRecord::Base
  # attr_accessible :title, :body



 # attr_accessible :title, :body
  attr_accessible :dispute_id,:file

 belongs_to :dispute


  mount_uploader :file, FileUploader





end
