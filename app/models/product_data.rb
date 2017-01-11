class ProductData < ActiveRecord::Base
  belongs_to :vitrine
  belongs_to :category
  belongs_to :subcategory
  belongs_to :gender
  has_many :images
 # belongs_to :material
  #belongs_to :condition
  #belongs_to :brand

  #belongs_to :color
  ##belongs_to :size

  #attr_accessible :id, :slug, :name, :detail, :price, :color_id, :gender_id,
    #              :category_id, :subcategory_id, :material_id, :condition_id, :vitrine_id,
    #              :brand_id, :meta_keywords, :size_id, :height, :quantity, :status




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

 
  accepts_nested_attributes_for :sizes, :sizeships, :colors, :colorships, :images, :brand, :material , :condition, 
    :conditionships, :materialships, :brandships

  

  attr_accessible  :name, :detail, :price, :color_id, :gender_id,
                   :category_id, :subcategory_id, :material_id, :condition_id,
                   :brand_id, :meta_keywords, :quantity, :status, :vitrine_id, :products, :price,
                   :size_ids, :color_ids, :state, :tag_list, :is_shared_on_facebook,
                   :is_shared_on_twitter,:brand_attributes, :images_attributes



end
