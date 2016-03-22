class City < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  attr_accessible :name, :code, :state_id # , :capital
  belongs_to :state
  has_many :users

  accepts_nested_attributes_for :users

end
