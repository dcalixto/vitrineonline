class Brand < ActiveRecord::Base
  attr_accessible :name
   has_one :product
has_one :order
has_one :product_data
  accepts_nested_attributes_for :product, :order, :product_data

 attr_reader :brand_tokens
  
  def brand_tokens=(ids)
    self.brand_ids = ids.split(",")
  end

end
