class Marketing < ActiveRecord::Base
 
  
include ActiveModel::Validations

  attr_accessible :vitrine_id
  belongs_to :vitrine
  attr_accessible :slogan, :url

  #validates :url, url: true, on: :update
  #
  #
  
  validates_presence_of :slogan,:url, nil: false

end
