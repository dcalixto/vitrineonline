class Section < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :vitrine # ,  :touch => true

  has_many :products

  validates_presence_of :name, on: :create
  accepts_nested_attributes_for :products

  attr_accessible :name

  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id], expires_in: 5.minutes) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  def cached_boutique
    Vitrine.cached_find(vitrine_id)
  end
end
