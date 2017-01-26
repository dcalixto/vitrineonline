class Size < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :size
 # has_many :orders 
  has_many :sizeships
  has_many :products, :through => :sizeships
  has_many :orders, :through => :sizeships
 accepts_nested_attributes_for :products, :orders,  :product_data

has_one :product_data

cattr_accessor :form_steps do
    %w(first)
  end

  attr_accessor :form_step


 

  def required_for_step?(step)
    return true if form_step.nil?
    return true if form_steps.index(step.to_s) <= form_steps.index(form_step)


  end
  

#def product
 # Product.find(:id)
#end

#def active?
#  product.status == 'active'
#end




end
