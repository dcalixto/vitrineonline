class Product < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: [:slugged, :history]

  default_scope -> { order('created_at DESC') }

  belongs_to :vitrine
  belongs_to :category
  belongs_to :subcategory
  has_many :orders
  has_many :feedbacks, through: :orders
 
  belongs_to :gender
  belongs_to :material
  belongs_to :condition
  belongs_to :brand

  has_and_belongs_to_many :colors
  #has_and_belongs_to_many :sizes
has_many :sizeship
has_many :sizes, through: :sizeship

 accepts_nested_attributes_for :sizes, :sizeship
  has_many :impressions, dependent: :destroy

  attr_accessible :f1, :f2, :f3, :f4, :name, :detail, :price, :color_id, :gender_id,
                  :category_id, :subcategory_id, :material_id, :condition_id,
                  :brand_id,  :meta_keywords, :quantity, :status, :vitrine_id, :products, :price,
                  :size_ids, :color_ids,:state, :tag_list

  validates :name, presence: true, length: { maximum: 140 }
  validates :price, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  
  
  mount_uploader :f1, F1Uploader
  mount_uploader :f2, F2Uploader
  mount_uploader :f3, F3Uploader
  mount_uploader :f4, F4Uploader
  
  
  acts_as_votable

  acts_as_taggable # Alias for acts_as_taggable_on :tags

  acts_as_taggable_on :tags # Tagging products

  # validates :name,      :presence => true, :if => :active_or_name?
  #  validates :two,     :presence => true, :if => :active_or_two?
  #  validates :preview,  :presence => true, :if => :active_or_preview?


  # scope :open_orders, -> { where(workflow_state: "open") }

  #

  #include Elasticsearch::Model 
#include Elasticsearch::Model::Callbacks
#include Elasticsearch::Persistence::Model


  markable_as :favorite
  
  cattr_accessor :form_steps do
     %w(first)
   end

   attr_accessor :form_step

   #validates :name, :owner_name, presence: true, if: -> { required_for_step?(:identity) }
   #validates :identifying_characteristics, :colour, presence: true, if: -> { required_for_step?(:characteristics) }
   #validates :special_instructions, presence: true, if: -> { required_for_step?(:instructions) }

   def required_for_step?(step)
     return true if form_step.nil?
     return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
   end

  # validates :name, presence: true, if: -> { required_for_step?(:first) }
  # validates :color,  presence: true, if: -> { required_for_step?(:second) }
  # validates :image, presence: true, if: -> { required_for_step?(:preview) }

  # def required_for_step?(step)
  #  return true if form_step.nil?
  #  return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  # end

  #  def active_or_name?
  #  (status || '').include?('name') || active?
  # end

  #    def active_or_price?
  #      state.include?('two') || active?
  #    end

  #    def active_or_category?
  #      state.include?('preview') || active?
  #    end

  # def self.by_price(price)
  #  return scoped unless price.present?
  # end

  # def self.by_buyer_rating(buyer_rating)
  #  return scoped unless buyer_rating.present?
  #  where("eedbacks.buyer_rating =?", buyer_rating)
  # end

 # default_scope -> { order(:cached_votes_up) }

  scope :for_ids_with_order, ->(ids) {
    order = ids.blank? ? nil : "(#{ids.map{|i| "id=#{i}"}.join(',')}) DESC"
    where(:id => ids).order(order)
  }

  # GET VISITOR ID
  def impression_count
    impressions.count
  end

  # CACHE


  def subtotal
    quantity * price
  end

  def buyable?(user)
    if user.cart
      orders = user.cart.orders.where('seller_id = ?', vitrine.id)
      orders.each do |order|
        return false if order.quantity == quantity if order.product.id == id
      end

    end
    vitrine.owner?(user) == false && quantity > 0
   end

  # require 'file_size_validator'


  # validates  :f1, :f2,
  #
  #    :file_size => {
  #    :maximum => 2.megabytes.to_i
  #  }

 

  after_touch :reindex

  after_commit ->(product) {
    ProductRecommender.delay.add_product(product)
  }, :if => :persisted?

  after_commit ->(product) {
    ProductRecommender.delay.delete_product(product)
  }, on: :destroy


  searchkick word_start: [:name],
             suggest: ["name"],
             highlight: [:name],
             merge_mappings: true, mappings: {
             product: {
              properties: {
                  name: {type: "string", analyzer: "keyword", boost: 100}
              }
          }
      }
 






  def self.aggs_search(params)
    query = params[:query].presence || "*"
    conditions = {}
    conditions[:gender_id] = params[:gender_id] if params[:gender_id].present?
    conditions[:vitrine_id] = params[:vitrine_id] if params[:vitrine_id].present?
    conditions[:category_id] = params[:category_id] if params[:category_id].present?
    conditions[:subcategory_id] = params[:subcategory_id] if params[:subcategory_id].present?
    conditions[:size_id] = params[:size_id] if params[:size_id].present?
    conditions[:color_id] = params[:color_id] if params[:color_id].present?
    conditions[:material_id] = params[:material_id] if params[:material_id].present?
    conditions[:condition_id] = params[:condition_id] if params[:condition_id].present?
    conditions[:brand_id] = params[:brand_id] if params[:brand_id].present?
    conditions[:quantity] = {gt: 0} # quantity should be greather than 0
 
    products = Product.search query, fields: [{name: :word_start}], where: conditions,

    aggs: [:gender_id, :vitrine_id, :category_id, :subcategory_id, :size_id, :color_id, :material_id, :condition_id, :brand_id],
    page: params[:page], suggest: true, highlight: true, per_page: 10
  
    products
end

  def search_data
    {
        name: name,
        price: price,
        quantity: quantity,
        gender_id: gender_id,
        vitrine_id: vitrine_id,
        category_id: category_id,
        subcategory_id: subcategory_id,
        size_id: sizes.map(&:id),
        color_id: colors.map(&:id),
        material_id: material_id,
        condition_id: condition_id,
        brand_id: brand_id,
        created_at: created_at
    }
  end





 end


