class Vitrine < ActiveRecord::Base

  extend FriendlyId
  #include ActiveModel::Validations
  friendly_id :name, use: [:slugged, :history]

  belongs_to :user

  has_one :policy, dependent: :destroy

  has_many :products, dependent: :destroy
has_many :reports, as: :reportable
  has_one :marketing, dependent: :destroy
  has_many :views, dependent: :destroy

  has_many :feedbacks, dependent: :destroy

  has_many :orders, foreign_key: 'seller_id'
  has_many :invoices, through: :orders, source: :transaction

  has_many :announcements, dependent: :destroy
  has_many :banners, dependent: :destroy

  #has_many :offers                 # Allow user to report others
   has_many :offers, as: :offertable #

  belongs_to :city
  belongs_to :state


 validates_presence_of :about, nil: false


  mount_uploader :logo, LogoUploader




reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      # populate your model

       obj.user.city.name    = geo.city
      obj.user.state.code = geo.state_code
      obj.postal_code = geo.postal_code
         end
  end
  after_validation :fetch_address


has_reputation :votes, source: :user, aggregated_by: :sum
#usar_como_cnpj_ou_cpf :codigo





  acts_as_votable







  def vitrine_name
    "#{name}"
  end

  def vitrine_address
    "#{address}"
  end

  def vitrine_city
    "#{city.name}, #{state.code}"
  end

  def vitrine_neighborhood
    "#{neighborhood}"
  end

  def vitrine_postal_code
    "#{postal_code}"
  end

  def views_count
    views.count
  end

  def owner?(user)
    self.user == user
  end

  def vitrine_name
    "#{name}"
  end

  def tag_list
    # collect tags for current vitrine (through taggings->products->vitrine association)
    ActsAsTaggableOn::Tag.joins(:taggings).joins("inner join products on products.id = taggings.taggable_id and taggings.taggable_type = 'Product'").where('products.vitrine_id = ?', id).group('tags.id').order(:name)
  end


  before_create :build_default_models

  accepts_nested_attributes_for :policy, :products, :banners,
                                :marketing, allow_destroy: true

  validates :name, uniqueness: { case_sensitive: false },
                   length: { within: 1..70 }

  attr_accessible :name, :about, :logo, :b1, :banner, :b2, :b3, :website, :ad, :slogan,
                  :address, :neighborhood, :latitude, :longitude,  :neighborhood,  :postal_code, :address_supplement, :code, :about






  # CACHE

  private

  def build_default_models
    build_policy
    build_marketing

    true
  end
end
