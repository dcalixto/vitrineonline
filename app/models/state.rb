class State < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  #
  attr_accessible  :code,:name
  has_many :cities
  has_many :users
has_many :vitrines
  accepts_nested_attributes_for :users, :vitrines

#  after_commit :flush_cache

#  def self.cached_find(id)
#    Rails.cache.fetch([name, id], expires_in: 5.minutes) { find(id) }
#  end

#  def flush_cache
#    Rails.cache.delete([self.class.name, id])
#  end
end
