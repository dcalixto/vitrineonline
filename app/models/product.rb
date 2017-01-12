class Product < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: [:slugged, :history]

  default_scope -> { order('created_at DESC') }

  belongs_to :vitrine
  belongs_to :category
  belongs_to :subcategory
  has_many :images, dependent: :destroy

  has_many :feedbacks

  has_many :reports
  has_many :orders
  belongs_to :gender



  #belongs_to :material
 # belongs_to :condition
  #belongs_to :brand



 has_many :brandships
  has_many :brands, :through => :brandships



  has_many :materialships
  has_many :materials, :through => :materialships


  has_many :conditionships
  has_many :conditions, :through => :conditionships


  has_many :sizeships
  has_many :sizes, through: :sizeships

  has_many :colorships
  has_many :colors, through: :colorships
  has_many :impressions,  as: :impressionable, dependent: :destroy

 
  accepts_nested_attributes_for :sizes, :sizeships, :colors, :colorships, :images,     :conditionships, :materialships, :brandships

  

  attr_accessible  :name, :detail, :price, :color_id, :gender_id,
                   :category_id, :subcategory_id, :material_id, :condition_id,
                   :brand_id, :meta_keywords, :quantity, :status, :vitrine_id, :products, :price,
                   :size_ids, :color_ids, :state, :tag_list, :is_shared_on_facebook,
                   :is_shared_on_twitter,:brand_attributes, :images_attributes


  validates :name, presence: true, length: { maximum: 140 }
  validates :price, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

 acts_as_votable 
  #

  acts_as_taggable # Alias for acts_as_taggable_on :tags

  # validates :name,      :presence => true, :if => :active_or_name?
  #  validates :two,     :presence => true, :if => :active_or_two?
  #  validates :preview,  :presence => true, :if => :active_or_preview?

  # scope :open_orders, -> { where(workflow_state: "open") }

  cattr_accessor :form_steps do
    %w(first)
  end

  attr_accessor :form_step

  def required_for_step?(step)
    return true if form_step.nil?
    return true if form_steps.index(step.to_s) <= form_steps.index(form_step)
  end

  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id], expires_in: 5.minutes) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  def cached_product
    Product.cached_find(product_id)
  end

  scope :for_ids_with_order, ->(ids) {
    order = ids.blank? ? nil : "(#{ids.map { |i| "id=#{i}" }.join(',')}) DESC"
    where(id: ids).order(order)
  }

  # AVERAGE BUYER RATING
  def average_customer_rating
    feedbacks.where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating) || 0
  end

  # GET VISITOR ID
  def impression_count
    impressions.count
  end

  # CACHE

  def subtotal
    quantity * price
  end

  # CHECK IF CAN BUY
  def buyable?(user)
    if user.cart
      orders = user.cart.orders.where('seller_id = ?', vitrine.id)
      orders.each do |order|
        return false if order.product.id == id && (order.quantity == quantity)
      end

    end
    vitrine.owner?(user) == false && quantity > 0
   end

  after_touch :reindex

  after_commit ->(product) do
    ProductRecommender.delay.add_product(product)
  end, if: :persisted?

  after_commit ->(product) do
    ProductRecommender.delay.delete_product(product)
  end, on: :destroy

  searchkick word_start: [:name],
             autocomplete: ['name'],
             suggest: ['name'],
             highlight: [:name],
             merge_mappings: true, mappings: {
               product: {
                 properties: {
                   name: { type: 'string', analyzer: 'keyword', boost: 100 },
                   average_customer_rating: { type: 'double' }
                 }
               }
             }

  def self.aggs_search(params)
    query = params[:query].presence || '*'
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
    conditions[:quantity] = { gt: 0 } # quantity should be greather than 0

    order_by_param = params[:order_by] || 'created_at:desc'
    order_options = {}
    order_options[order_by_param.split(':')[0]] = {order: order_by_param.split(':')[1], ignore_unmapped: true}

    products = Product.search query, fields: [{ name: :word_start }], where: conditions,

                                     aggs: [:gender_id, :vitrine_id, :category_id, :subcategory_id, :size_id, :color_id, :material_id, :condition_id, :brand_id],
                                     page: params[:page], suggest: true, highlight: true, per_page: 22, order: [order_options, {created_at: {order: 'desc', ignore_unmapped: true}}]

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
      material_id: materials.map(&:id),
      brand_id: brands.map(&:id),
      condition_id: conditions.map(&:id),

     # material_id: material_id,
     ## condition_id: condition_id,
     ## brand_id: brand_id,
      created_at: created_at,
      average_customer_rating: average_customer_rating
    }
  end
 end
