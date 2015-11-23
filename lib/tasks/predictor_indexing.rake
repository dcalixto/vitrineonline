task :predictor_indexing => :environment do |x, args|

recommender = ProductRecommender.instance
  recommender.impressions.add_to_set("impression-1", ["product-3", "product-5", "product-6"])
  recommender.products.add_to_set("product-2", ["product7", "product8"])
  recommender.vitines.add_to_set("vitrine-1", ["product7", "product8"])
  recommender.process!

end
