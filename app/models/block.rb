class Block < ActiveRecord::Base
  attr_accessible :category


  has_many :products
  has_many :genders
has_many :categories
has_many :subcategories
has_many :eletronics
has_many :supplements
has_many :sports
has_many :houses

has_many :autos
has_many :foods
has_many :arts
has_many :books

has_many :tools
has_many :virtuals


accepts_nested_attributes_for :genders, :foods
  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :categories
 accepts_nested_attributes_for :subcategories


accepts_nested_attributes_for :eletronics,:autos,:arts, :books, :tools

accepts_nested_attributes_for :supplements, :virtuals
accepts_nested_attributes_for :sports
accepts_nested_attributes_for :houses




  

  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([category, id], expires_in: 5.minutes) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.category, id])
  end

  def cached_block
    Block.cached_find(block_id)
  end









end
