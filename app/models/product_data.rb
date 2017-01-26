class ProductData < ActiveRecord::Base
  belongs_to :vitrine
  belongs_to :category
  belongs_to :subcategory
  belongs_to :gender
  has_many :images
  belongs_to :material
  belongs_to :condition
  belongs_to :brand





  has_many :sizeships
  has_many :sizes, through: :sizeships

  has_many :colorships
  has_many :colors, through: :colorships
 
 
  accepts_nested_attributes_for :sizes, :sizeships, :colors, :colorships, :images, :brand, :material , :condition 
      

  attr_accessible  :id, :slug,:name,  :detail, :price,  :gender_id,
                   :category_id, :subcategory_id, :material_id, :condition_id,
                   :brand_id, :meta_keywords, :quantity, :status, :vitrine_id,  :price,
                   :size_ids, :color_ids,  :is_shared_on_facebook,
                   :is_shared_on_twitter, :images_attributes, :brand_id



end
