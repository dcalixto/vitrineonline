class Vitrine < ActiveRecord::Base
  extend FriendlyId
  # include ActiveModel::Validations
  friendly_id :name, use: [:slugged, :history]

  belongs_to :user, :inverse_of => :vitrine

  has_one :policy, dependent: :destroy,  :inverse_of => :vitrine

  has_many :products,:inverse_of => :vitrine,  dependent: :destroy

  has_one :marketing, dependent: :destroy


has_many :impressions,  as: :impressionable, dependent: :destroy

has_one :brand


  has_many :feedbacks 

  has_many :orders, foreign_key: 'seller_id'
  has_many :invoices, through: :orders, source: :transaction

  has_many :announcements, dependent: :destroy

  accepts_nested_attributes_for :policy
validates_associated :policy, presence: true
   attr_accessible  :policy_attributes, :branded


  validates_presence_of :code
  validates_uniqueness_of :code



  acts_as_votable
  

  
  # TODO: COUPONS AND REPORT
  # has_many :coupons, as: :couponable #
  # has_many :reports, as: :reportable

  belongs_to :city
  belongs_to :state




#include PublicActivity::Model

 # tracked owner: ->(controller, model) { controller && controller.current_user }

  mount_uploader :logo, LogoUploader

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      # populate your model

      obj.user.city.name = geo.city
      obj.user.state.code = geo.state_code
      obj.postal_code = geo.postal_code
         end
  end
  after_validation :fetch_address

   usar_como_cnpj_ou_cpf :codigo

  after_commit :flush_cache



 after_commit :clear_cache

  def clear_cache
    $redis.del "vitrines"
  end




  def self.cached_find(id)
    Rails.cache.fetch([name, id], expires_in: 5.minutes) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  def cached_vitrine
    Vitrine.cached_find(vitrine_id)
  end

  def vitrine_name
    name.to_s
  end

  def vitrine_address
    address.to_s
  end

  def vitrine_city
    "#{city.name}, #{state.code}"
  end

  def vitrine_neighborhood
    neighborhood.to_s
  end

  def vitrine_postal_code
    postal_code.to_s
  end

  def views_count
    views.count
  end

  def owner?(user)
    self.user == user
  end

  def vitrine_name
    name.to_s
  end

  def tag_list
    # collect tags for current vitrine (through taggings->products->vitrine association)
    ActsAsTaggableOn::Tag.joins(:taggings).joins("inner join products on products.id = taggings.taggable_id and taggings.taggable_type = 'Product'").where('products.vitrine_id = ?', id).group('tags.id').order(:name)
  end



  # AVERAGE BUYER RATING
  def average_customer_rating
    feedbacks.where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating) || 0
  end



  before_create :build_default_models

  accepts_nested_attributes_for :policy, :products,
                                :marketing, allow_destroy: true

  validates :name, uniqueness: { case_sensitive: false },
                   length: { within: 1..70 }

  attr_accessible :name, :about,:codigo, :logo, :banner, :ad, :slogan,
                  :address, :neighborhood, :latitude, :longitude, :neighborhood, :postal_code, :address_supplement, :code, :about

  # CACHE

  private

  def build_default_models
  #  build_policy
    build_marketing

    true
  end


protected
  def before_validation_on_create
    self.code = rand(36**8).to_s(36) if self.new_record? and self.code.nil?
  end




end
