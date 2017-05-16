class Order < ActiveRecord::Base

  STATUSES = %w(paid sent).freeze


  belongs_to :seller, foreign_key: 'seller_id', class_name: 'Vitrine'
  belongs_to :buyer, foreign_key: 'buyer_id', class_name: 'User'
  belongs_to :product, touch: true
 belongs_to :pdata

  belongs_to :cart
  belongs_to :feedback

  has_one    :transaction

  has_one :odata

  has_one :dispute


  belongs_to :color
  belongs_to :size

  belongs_to :brand,  foreign_key: 'brand_id', class_name: 'Brand'



  belongs_to :material, foreign_key: 'material_id', class_name: 'Material'



  belongs_to :condition, foreign_key: 'condition_id', class_name: 'Condition'


  accepts_nested_attributes_for :size,  :brand, :material,
    :condition, :transaction, :pdata


  attr_accessible :cart_id, :product_id, :purchased_at, :quantity,
    :buyer_id, :quantity, :seller_id, :shipping_cost, :shipping_method, 
    :status,  :color_id, :size_id,  :brand_id, :material_id,:condition_id, :track_number


  validates :shipping_cost, numericality: { greater_than: 0, allow_nil: true }


  scope :awaiting_feedback, ->(user) { joins('left join feedbacks on feedbacks.id = orders.feedback_id').where('(buyer_id = ? and buyer_feedback_date is null) or (seller_id = ? and seller_feedback_date is null)', user.id, user.vitrine ? user.vitrine.id : 0).where('status is not null').order(:created_at) }



 after_create  :create_pdata
  after_commit :createcode, on: :create
# after_commit  :update_odata, on: :update

  def decrease_products

    product.quantity -= quantity
    product.save

  end



  def createcode
    if code.blank?

      self.code = rand(36**8).to_s(36)
    end
  end





  after_commit ->(order) do
    ProductRecommender.add_order(order)
  end, on: :create



def create_pdata 
 
unless pdata
attrs = product.attributes.slice(
"color_id", "name", "code",
"vitrine_id","gender_id", "category_id", "subcategory_id",
"quantity","price", "brand_id", "condition_id"

)
puts attrs
pdata = Pdata.create!(attrs)
update_column :pdata_id, pdata.id
end
rescue => e
puts e.inspect
raise e
end











  def product
  
    prod = Product.find_by_id(attributes['product_id'])
    prod = Pdata.find_by_id(attributes['product_id']) if prod.nil?
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


  def store_fee
    total_price * configatron.store_fee
  end


  def new_user_address_path
    new_user_address_path
  end









end
