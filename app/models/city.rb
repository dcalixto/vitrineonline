class City < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  attr_accessible :name, :state_id # , :capital
  belongs_to :state
  has_many :users

  accepts_nested_attributes_for :users

  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id], expires_in: 5.minutes) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  def cached_state
    State.cached_find(state_id)
  end
end
