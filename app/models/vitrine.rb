class Vitrine < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  belongs_to :user

  has_one :policy, dependent: :destroy

  has_many :products, dependent: :destroy

  has_one :marketing, dependent: :destroy
  has_many :views, dependent: :destroy

  has_many :feedbacks, dependent: :destroy

  has_many :orders, foreign_key: 'seller_id'
  has_many :invoices, through: :orders, source: :transaction

  has_many :announcements, dependent: :destroy

  belongs_to :city
  belongs_to :state


  mount_uploader :logo, LogoUploader
   mount_uploader :b1, B1Uploader
    mount_uploader :b2, B2Uploader
 mount_uploader :b3, B3Uploader
  
 




 markable_as :favorite
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

  accepts_nested_attributes_for :policy, :products,
                                :marketing, allow_destroy: true

  validates :name, uniqueness: { case_sensitive: false },
                   length: { within: 1..70 }

  attr_accessible :name, :about, :logo, :b1,  :b2, :b3, :website, :ad, :slogan,
                  :address, :neighborhood, :postal_code, :code, :about

   




  # CACHE

  private

  def build_default_models
    build_policy
    build_marketing

    true
  end
end
