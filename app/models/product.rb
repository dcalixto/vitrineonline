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
        size_id: size_id,
        color_id: color_id,
        material_id: material_id,
        condition_id: condition_id,
        brand_id: brand_id,
        created_at: created_at
    }
  end




 # mapping do
  #  indexes :id, type: 'integer'
   # indexes :name, :analyzer => 'snowball', :boost => 100
    # indexes :gender_id, type: 'integer'
   # indexes :gender_gender, :as => 'gender.gender'
    #indexes :vitrine_id, type: 'integer'
   # indexes :vitrine_name, :as => 'vitrine.name'
  #  indexes :category_id, type: 'integer'
 #   indexes :category_name, :as => 'category.name'
 #   indexes :subcategory_id, type: 'integer'
 #   indexes :subcategory_name, :as => 'subcategory.name'
   # indexes :color_id, type: 'integer'
   # indexes :color_name, :as => 'color.name'
   # indexes :size_id, type: 'integer'
   # indexes :size, :as => 'size.size if size'
  #  indexes :material_id, type: 'integer'
  #  indexes :material_name, :as => 'material.name'
  #  indexes :condition_id, type: 'integer'
  #  indexes :condition_condition, :as => 'condition.condition'
  #  indexes :brand_id, type: 'integer'
  #  indexes :brand_name, :as => 'brand.name if brand'
      
  
 # end

  #def self.search(params)
    ##tire.search(:load => true, page: params[:page], per_page: 2 ) do
   #   query { string params[:query], default_operator: 'AND'} if params[:query].present?
    #  #filter :range, created_at: {lte: Time.zone.now}
     # filter :term, gender_id: params[:gender_id] if params[:gender_id].present?
      #filter :term, vitrine_id: params[:vitrine_id] if params[:vitrine_id].present?
      #filter :term, category_id: params[:category_id] if params[:category_id].present?
      #filter :term, subcategory_id: params[:subcategory_id] if params[:subcategory_id].present?
     # filter :term, color_id: params[:color_id] if params[:color_id].present?
      #filter :term, size_id: params[:size_id] if params[:size_id].present?
      #filter :term, material_id: params[:material_id] if params[:material_id].present?
      #filter :term, condition_id: params[:condition_id] if params[:condition_id].present?
    #  filter :term, brand_id: params[:brand_id] if params[:brand_id].present?


    #  aggs :gender do
    #    terms :gender_id
    #  end

    #  aggs :vitrine do
     #   terms :vitrine_id
    #  end

    #  aggs :category do
     #   terms :category_id
    #  end

    #  aggs :subcategory do
    #    terms :subcategory_id
    #  end

    # aggs :color do
     #   terms :color_id
    #  end

    #  aggs :size do
    #    terms :size_id
    #  end

   #  aggs :material do
   #     terms :material_id
   #   end

   #   aggs :condition do
   #     terms :condition_id
   #   end

   #   aggs :brand do
   #     terms :brand_id
   #   end
   

    #end
 # end




 # settings index: {number_of_shards: 1} do

   #   mappings dynamic: 'false' do
   #   indexes :name,  :type => 'string'
  #    indexes :category_name, :type => 'string'
 #     indexes :subcategory_name, :type => 'string'
   #   indexes :material_name, :type => 'string'
 #      indexes :condition_condition, :type => 'string'
   #    indexes :brand_name, :type => 'string'
    #  indexes :vitrine_id, :type => 'string'
   
    
    
  #  end
#  end


#  def self.search(query)
  #  __elasticsearch__.search(
  #          {
    #    query: {
     #     query_string: {
     #       query: query,
      #      fuzziness: 2,
     #       default_operator: "AND",
     #       fields: ['name^10', 'price', 'vitrine_name', 'id']
    #      }
     #   },

# aggs: {genders: { terms: { field: :gender} }},
 #aggregations:  {categories: { terms: { field: :category_id} }},
#  aggs:  {subcategories: { terms: { field: :name} }},
 # aggs:  {materials: { terms: { field: :name} }},
 #aggs:  {conditions: { terms: { field: :condition} }},
# aggs:  {brands: { terms: { field: :name} }},
#  aggs: {avg_price: { avg: { field: :price } } },

  #      highlight: {
 #         pre_tags: ['<em>'],
   #       post_tags: ['</em>'],
  #        fields: {
    #        name: {},
     #       description: {}
     #     }
   #     }
  #    }
  #  )
 # end



 
#Product.__elasticsearch__.client.indices.delete index: Product.index_name rescue nil

# Create the new index with the new mapping
#Product.__elasticsearch__.client.indices.create \
  #index: Product.index_name,
 # body: { settings: Product.settings.to_hash, mappings: Product.mappings.to_hash }

# Index all article records from the DB to Elasticsearch
#Product.import(force: true)


 end


