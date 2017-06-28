class Product < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: [:slugged, :history]

  default_scope -> { order('created_at DESC') }

  belongs_to :vitrine, :inverse_of => :products
  belongs_to :category
  belongs_to :subcategory
  belongs_to :transaction

 belongs_to :eletronic
 belongs_to :supplement
belongs_to :auto
belongs_to :house
belongs_to :book

belongs_to :art
belongs_to :virtual

  has_many :images,inverse_of: :product #, dependent: :destroy 
  has_many :orders, dependent: :destroy
  has_many :feedbacks, through: :orders#, inverse_of: :product
  

 has_many :probacks


  belongs_to :gender
  belongs_to :brand

  belongs_to :condition
  belongs_to :material


  has_many :sizeships
  has_many :sizes, through: :sizeships

  has_many :colorships
  has_many :colors, through: :colorships
  has_many :impressions,  as: :impressionable, dependent: :destroy

  accepts_nested_attributes_for :sizes, :sizeships, :colors, :colorships, :images,   
    :brand,:condition,:material

  attr_accessible  :name, :detail, :price, :gender_id,
    :category_id, :subcategory_id, :material_id, :meta_keywords, :quantity, :status,
    :vitrine_id, :products, :price,
    :size_ids, :color_ids,  :tag_list, :is_shared_on_facebook,
    :is_shared_on_twitter,:images_attributes, 
    :brand_id, :obrand_id, :condition_id, :height, :width, :diamenter, :length, :weight, :freeship,
    :block_id, :eletronic_id,
    :supplement_id, :sport_id, :auto_id, :house_id, :food_id, :art_id, :book_id, :tool_id, :virtual_id,
    :diameter

    



    
  validates :name, presence: true, length: { maximum: 140 }
  validates :price, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }




  
   before_create  :createcode
 #  after_create  :create_pdata


   after_save :load_into_soulmate
	before_destroy :remove_from_soulmate



 def createcode
    if code.blank?
    self.code = rand(36**8).to_s(36)
    end
  end

  acts_as_votable 
  #

  acts_as_taggable # Alias for acts_as_taggable_on :tags

  # scope :open_orders, -> { where(workflow_state: "open") }




  cattr_accessor :form_steps do
    %w(first)
  end

  attr_accessor :form_step

 def percent_of(n)
    self.to_f / n.to_f * 100.0
  end


  def required_for_step?(step)
    return true if form_step.nil?
    return true if form_steps.index(step.to_s) <= form_steps.index(form_step)


  end
  #validates :color_ids, :presence => true, :if => :active?
  #validates :eletronic_id, :presence => true, :if => :active?
 # validates :condition_id, :presence => true, :if => :active?

  validates :images, :presence => true, :if => :active?
  def active?
    status == 'active'
  end







  after_commit :flush_cache



#  def create_pdata
#    product = Product.find_by_id(attributes['id'])

  #  if status == Order.statuses[0]
  #    pr_id = product.id
  #    data = Pdata.find_by_id(pr_id)
    #  if data.nil?
    #    attrs = product.attributes
    #    attrs.delete('created_at')
    #    attrs.delete('updated_at')
    #    data = Pdata.create(attrs)

            
    #    data.save
     # end
      
#
  #  end


#  end














  def fetch_images
    Rails.cache.fetch([id, 'images']) { images.to_a }
  end



  def self.cached_find(id)
    Rails.cache.fetch([name, id], expires_in: 5.minutes) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])

    images.each do |images|
      Rails.cache.delete([images.ifoto_id, 'ifoto'])
    end
  end

  def cached_product
    Product.cached_find(product_id)
  end





  after_commit :clear_cache

  def clear_cache
    $redis.del "products"
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
    impressions.size
  end

  def unique_impression_count
    # impressions.group(:ip_address).size gives => {'127.0.0.1'=>9, '0.0.0.0'=>1}
    # so getting keys from the hash and calculating the number of keys
    impressions.group(:ip_address).size.keys.length #TESTED
  end




  # CACHE

  def subtotal
    quantity * price
  end




  #PRICE FIX
  def price=(price)
    write_attribute(:price, price.tr(',', '.'))
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
    ProductRecommender.add_product(product)
  end, if: :persisted?

  after_commit ->(product) do
    ProductRecommender.delete_product(product)
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
     conditions[:eletronic_id] = params[:eletronic_id] if params[:eletronic_id].present?


      conditions[:quantity] = { gt: 0 } # quantity should be greather than 0

      order_by_param = params[:order_by] || 'created_at:desc'
      order_options = {}
      order_options[order_by_param.split(':')[0]] = {order: order_by_param.split(':')[1], ignore_unmapped: true}

      products = Product.search query, fields: [{ name: :word_start }], where: conditions,
        include: [:images, :feedbacks,:vitrine],
        aggs: [:gender_id, :vitrine_id, :category_id, :subcategory_id, :size_id, :color_id, :material_id, :condition_id, :brand_id, :eletronic_id],
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
        material_id: material_id,
        brand_id: brand_id,
        eletronic_id: brand_id,

        condition_id: condition_id,
        created_at: created_at,
        average_customer_rating: average_customer_rating
      }
    end






    private

    def build_default_models
      #  build_policy
      images.build

      true
    end








	def load_into_soulmate
		loader = Soulmate::Loader.new("products")
		loader.add("term" => name, "id" => self.id, "data" => {
			"link" => Rails.application.routes.url_helpers.product_path(self)
	   	})
	end

	def remove_from_soulmate
		loader = Soulmate::Loader.new("products")
	    loader.remove("id" => self.id)
	end



end
