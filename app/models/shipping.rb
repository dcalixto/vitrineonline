class Shipping < ActiveRecord::Base
  attr_accessible :kind
  # has_and_belongs_to_many :policy

  has_many :policies, through: :shipman

  has_many :shipman
end
