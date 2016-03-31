class ProductData < ActiveRecord::Base
  belongs_to :vitrine
  belongs_to :category
  belongs_to :subcategory
  belongs_to :gender
   has_many :images
  belongs_to :material
  belongs_to :condition
  belongs_to :brand

  belongs_to :color
  belongs_to :size

  attr_accessible :id, :slug, :name, :detail, :price, :color_id, :gender_id,
                  :category_id, :subcategory_id, :material_id, :condition_id, :vitrine_id,
                  :brand_id, :meta_keywords, :size_id, :height, :quantity, :status



end
