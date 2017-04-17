class Pdata < ActiveRecord::Base
  # attr_accessible :title, :body


 belongs_to :vitrine
  belongs_to :category
  belongs_to :subcategory
  belongs_to :gender
  belongs_to :material
  belongs_to :condition
  belongs_to :brand

 
  accepts_nested_attributes_for  :images, :brand, :material , :condition       

  attr_accessible  :id, :slug,:name,  :detail, :price,  :gender_id,
                   :category_id, :subcategory_id, :material_id, :condition_id,
                   :brand_id, :meta_keywords, :quantity, :status, :vitrine_id,  :price,
                    :is_shared_on_facebook,
                   :is_shared_on_twitter, :images_attributes, :brand_id





end
