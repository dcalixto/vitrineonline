class ProductData < ActiveRecord::Base
  belongs_to :vitrine
  belongs_to :category
  belongs_to :subcategory
  belongs_to :gender

  belongs_to :material
  belongs_to :condition
  belongs_to :brand

  belongs_to :color
  belongs_to :size

  attr_accessible :id, :slug, :name, :detail, :price, :color_id, :gender_id,
                  :category_id, :subcategory_id, :material_id, :condition_id, :vitrine_id,
                  :brand_id, :meta_keywords, :size_id, :height, :quantity, :status

  mount_uploader :f1, F1Uploader
  mount_uploader :f2, F2Uploader
  mount_uploader :f3, F3Uploader
  mount_uploader :f4, F4Uploader
end
