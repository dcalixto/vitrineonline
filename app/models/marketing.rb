class Marketing < ActiveRecord::Base


#include ActiveModel::Validations

  attr_accessible :vitrine_id
  belongs_to :vitrine
  attr_accessible :slogan, :url



end
