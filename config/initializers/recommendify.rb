# Our similarity matrix, we calculate the similarity via co-concurrence
# of products in "orders" using the jaccard similarity measure.
#class ProductRecommender < Recommendify::Base

  # store only the top fifty neighbors per item
  #max_neighbors 50

  # define an input data set "order_items". we'll add "order_id->product_id"
  # pairs to this input and use the jaccard coefficient to retrieve a
  # "customers that ordered item i1 also ordered item i2" statement and apply
  # the result to the item<->item similarity matrix with a weight of 5.0
  #input_matrix :impressions,
    # :native => true,
  #  :similarity_func => :jaccard,
  #  :weight => 5.0

#end

#Recommendify.redis = Redis.new#(:url => ENV["RECOMENDIFY_REDIS"])
#recommender = ProductRecommender.new

#recommender.impressions.add_set("product1", ["product23", "product65", "product23"])
#recommender.impressions.add_set("product", ["product14", "product23"])


#recommender.process!
