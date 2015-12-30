#Predictor.redis = Redis.new
#Predictor.redis = Redis.new(:url => ENV["PREDICTOR_REDIS"])





#@recommender = ProductRecommender.instance


# Add records to the recommender.
#@recommender.add_to_matrix!(:impressions, "product-1", "product-2")
#@recommender.add_to_matrix!(:products, "product-4", "product-3", "product-#{:product_id}")
#@recommender.add_to_matrix!(:vitrines, "log_view-1", "vitrine-1")
#@recommender.add_to_matrix!(:feedbacks, "product-1", "product-2")
#@recommender.add_to_matrix!(:taggings, "tag-2", "tag-3")
#@recommender.add_to_matrix!(:orders, "product-1", "product-2")

#@recommender.products.add_to_set("product-3", "#{:id}", "#{:name}", "#{:price}")

#@recommender.predictions_for(item_set: ["product-3", "product-5"])
#@recommender.predictions_for("user-2", matrix_label: :users)

#@recommender.process!
