require 'singleton'
class ProductRecommender
  include Predictor::Base
  include Singleton

  limit_similarities_to 30

  input_matrix :impressions, weight: 1.0
  input_matrix :orders, weight: 2.0

  input_matrix :vitrines, weight: 0.5
  input_matrix :taggings, weight: 0.5

  def self.add_product(product)
    # incrementally update vitrines matrix
    instance.vitrines.add_to_set(product.vitrine.id, product.id)
    # incrementally update taggings matrix
    product.tags.each do |tag|
      instance.taggings.add_to_set(tag.id, product.id)
    end
    instance.process_items!(product.id)
  end

  def self.add_impression(impression)
    # incrementally update impressions matrix
    product_id = impression.product.id
    instance.impressions.add_to_set(impression.ip_address, product_id)
    instance.process_items!(product_id)
  end

  def self.add_order(order)
    # incrementally update orders matrix
    product_id = order.product.id
    instance.orders.add_to_set(order.buyer_id, product_id)
    instance.process_items!(product_id)
  end

  def self.delete_product(product)
    # delete product from all matrices
    instance.delete_item!(product.id)
  end

end