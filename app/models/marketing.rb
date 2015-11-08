class Marketing < ActiveRecord::Base
  attr_accessible :vitrine_id
  belongs_to :vitrine
  attr_accessible :slogan, :url

  validates :url, url: true, on: :update
end
