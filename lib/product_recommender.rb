require 'singleton'
class ProductRecommender
  include Predictor::Base
  include Singleton
  input_matrix :products, weight: 3.0
  input_matrix :impressions, weight: 2.0
end
