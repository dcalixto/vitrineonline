require 'singleton'
class ProductRecommender
  include Predictor::Base
  include Singleton
  input_matrix :products, weight: 5.0
  input_matrix :impressions, weight: 3.0
 input_matrix :vitrines, weight: 1.0, measure: :sorensen_coefficient # Use Sorenson over Jaccard
 input_matrix :users,  weight: 2.0
  input_matrix :orders,  weight: 3.0
input_matrix :feedbacks,  weight: 1.0
input_matrix  :taggings, weight: 1.0

end
