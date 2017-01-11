class Order < ActiveRecord::Base

  STATUSES = %w(paid sent).freeze


  belongs_to :seller, foreign_key: 'seller_id', class_name: 'Vitrine'
  belongs_to :buyer, foreign_key: 'buyer_id', class_name: 'User'
  belongs_to :product, touch: true
  belongs_to :color
  belongs_to :size
  belongs_to :cart
  belongs_to :feedback
 
  has_one    :transaction
  has_many :colorships
  has_many :colors, :through => :colorships
  has_many :sizeships

  has_many :sizes, :through => :sizeships


  has_many :brandships
  has_many :brands, :through => :brandships



  has_many :materialships
  has_many :materials, :through => :materialships


  has_many :conditionships
  has_many :conditions, :through => :conditionships

  accepts_nested_attributes_for :sizes, :sizeships, :colors, :colorships,  :brand, :brandships, :material, :materialships,
    :condition, :conditionships



  attr_accessible :cart_id, :product_id, :purchased_at, :quantity,
    :buyer_id, :quantity, :seller_id, :shipping_cost, :shipping_method, 
    :status, :size_ids, :color_ids,  :orderable_type, :brand_ids, :material_ids,:condition_ids


  validates :shipping_cost, numericality: { greater_than: 0, allow_nil: true }


  scope :awaiting_feedback, ->(user) { joins('left join feedbacks on feedbacks.id = orders.feedback_id').where('(buyer_id = ? and buyer_feedback_date is null) or (seller_id = ? and seller_feedback_date is null)', user.id, user.vitrine ? user.vitrine.id : 0).where('status is not null').order(:created_at) }

  after_update :create_product_data

  after_commit ->(order) do
    ProductRecommender.delay.add_order(order)
  end, on: :create

  def create_product_data
    if status == Order.statuses[0]
      pr_id = product.id
      data = ProductData.find_by_id(pr_id)
      if data.nil?
        attrs = product.attributes
        attrs.images.first.delete('foto')
        attrs.delete('created_at')
        attrs.delete('updated_at')
        data = ProductData.create(attrs)
        data.f1 = product.images.first
        data.color = product.colors
        data.size =  product.sizes
        data.condition =  product.conditions
        data.brand =  product.brands

        data.save
      end
    end
  end

  def product
    prod = Product.find_by_id(attributes['product_id'])
    prod = ProductData.find_by_id(attributes['product_id']) if prod.nil?
    prod
  end

  def shipping_cost=(shipping_cost)
    write_attribute(:shipping_cost, shipping_cost.tr(',', '.'))
  end

  STATUSES.each do |method|
    define_method "#{method}?" do
      status == method
    end
  end

  def self.statuses
    STATUSES
  end

  def total_price
    product.price * quantity
  end

  def decrease_products_count
    product.quantity -= quantity
    product.save
    OrderMailer.delay.order_confirmation(self)
  end

  def store_fee
    total_price * configatron.store_fee
  end
end
