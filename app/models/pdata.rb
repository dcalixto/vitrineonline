class Pdata < ActiveRecord::Base
  # attr_accessible :title, :body


  belongs_to :vitrine
  belongs_to :category
  belongs_to :subcategory
  belongs_to :gender
  belongs_to :material
  belongs_to :condition
  belongs_to :brand
  has_many :probacks
  has_many :odatas
  has_many :order
  has_many :images
  accepts_nested_attributes_for   :brand, :material , :condition, :images




attr_accessible :impressions_count, :color_id, :size_id, :current_step, :is_shared_on_facebook, :is_shared_on_twitter, 
  :cached_votes_total, :cached_votes_score, :cached_votes_up, :cached_votes_down, :cached_weighted_score, 
  
  :cached_weighted_total, :cached_weighted_average, :buyer_rating, :transaction_id, :buyer_feedback_date, 
  :feedback_counter, :rate_from_buyers, :total_feedbacks, :average_rating, :obrand_id, :branded, :weight, 
  :length, :width, :height, :diamenter, :code,
  :id, :vitrine_id, :slug, :name, :price, :detail, :gender_id, :category_id, :subcategory_id, 
  :brand_id, :material_id, :condition_id, :meta_keywords, :quantity, :status,:order_id,:odata_id





end
