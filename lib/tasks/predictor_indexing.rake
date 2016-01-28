namespace :predictor do
  desc "build predictor index for products from scratch"
  task :product_indexing => :environment do
    recommender = ProductRecommender.instance

    #clear index
    recommender.clean!

    # Add records to the recommender

    # Impressions (Users that viewed this product also viewed...      ip_address --> product_id pairs)
    impressions_data = Impression.connection.execute('SELECT ip_address, array_to_json(array_agg(product_id)) as product_ids FROM impressions GROUP BY ip_address')
    impressions_data.each { |row| recommender.impressions.add_to_set(row['ip_address'], eval(row['product_ids'])) }

    # Orders (Users that bought this product also bought...      buyer_id --> product_id pairs)
    orders_data = Order.connection.execute('SELECT buyer_id, array_to_json(array_agg(product_id)) as product_ids FROM orders GROUP BY buyer_id')
    orders_data.each { |row| recommender.orders.add_to_set(row['buyer_id'], eval(row['product_ids'])) }

    # Vitrines (Vitrines that include this product also include...      vitrine_id --> product_id pairs)
    vitrines_data = Product.connection.execute('SELECT vitrine_id, array_to_json(array_agg(id)) as product_ids FROM products GROUP BY vitrine_id')
    vitrines_data.each { |row| recommender.vitrines.add_to_set(row['vitrine_id'], eval(row['product_ids'])) }

    # Taggings (Tags that was added for this product also was added for...      tag_id --> product_id pairs)
    taggings_data = ActiveRecord::Base.connection.execute("SELECT tag_id, array_to_json(array_agg(taggable_id)) as product_ids FROM taggings WHERE taggable_type = 'Product' GROUP BY tag_id")
    taggings_data.each { |row| recommender.taggings.add_to_set(row['tag_id'], eval(row['product_ids'])) }

    recommender.process!
  end
end