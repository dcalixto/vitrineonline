class Eletronic < ActiveRecord::Base
   
 attr_accessible :item, :slug



has_many :products

belongs_to :ebrand
belongs_to :block



  accepts_nested_attributes_for :products
  

  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([item, id], expires_in: 5.minutes) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.item, id])
  end

  def cached_categiry
    Eletronic.cached_find(eletronic_id)
  end


#after_commit :clear_cache

#  def clear_cache
#    $redis.del "eletronics"
#  end





end
