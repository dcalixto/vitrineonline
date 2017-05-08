class City < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  attr_accessible :name, :state_id # , :capital
  belongs_to :state
  has_many :users
 has_many :vitrines
  accepts_nested_attributes_for :users, :vitrines

end
