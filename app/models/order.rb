class Order < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :purchased_at,
    :buyer_id, :quantity, :seller_id, :shipping_cost, :shipping_method,  :status


  STATUSES = %w(paid sent)

  belongs_to :cart

  belongs_to :seller, foreign_key: "seller_id", class_name: "Vitrine"
  belongs_to :buyer, foreign_key: "buyer_id", class_name: "User"
  belongs_to :product ,  :touch => true
  belongs_to :color
  belongs_to :size
  belongs_to :material
  belongs_to :gender
  belongs_to :category
  belongs_to :subcategory
  belongs_to :brand
 belongs_to :condition
  has_one    :transaction
  belongs_to :feedback
  attr_accessible :shipping_method, :shipping_cost, :status, :quantity
  validates :shipping_cost, numericality: { greater_than: 0, allow_nil: true }


scope :awaiting_feedback, ->(user) { joins('left join feedbacks on feedbacks.id = orders.feedback_id').where('(buyer_id = ? and buyer_feedback_date is null) or (seller_id = ? and seller_feedback_date is null)', user.id, user.vitrine ? user.vitrine.id : 0).where('status is not null').order(:created_at) }


  after_update :create_product_data

  after_commit ->(order) {
    ProductRecommender.delay.add_order(order)
  }, on: :create

  def create_product_data
    if status == Order.statuses[0]
      pr_id = product.id
      data = ProductData.find_by_id(pr_id)
      if data.nil?
        attrs = product.attributes
        attrs.delete('f1')
        attrs.delete('f2')
        attrs.delete('f3')
        attrs.delete('f4')
        attrs.delete('created_at')
        attrs.delete('updated_at')
        data = ProductData.create(attrs)
        data.f1 = product.f1
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
    write_attribute(:shipping_cost, shipping_cost.gsub(',', '.'))
  end



  STATUSES.each do |method|
    define_method "#{method}?" do
      self.status == method
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
