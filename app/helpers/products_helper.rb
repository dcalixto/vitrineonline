# encoding: utf-8
module ProductsHelper
  def mede(medida = false)
    if medida
      return "#{medida}cm"
    else
      return '----'
    end
  end

  def render_showcase
    render partial: 'showcase'
  end



  def options_for_tags(product_tags)
    (ActsAsTaggableOn::Tag.most_used(30) + product_tags).map(&:name).uniq.sort
  end


  include ActsAsTaggableOn::TagsHelper





  def fetch_products
    products =  $redis.get("products")
    if products.nil?
      products = Product.all.to_json
      $redis.set("products", products)
      # Expire the cache, every 3 hours
      $redis.expire("products",3.hour.to_i)
    end
    @products = JSON.load products
  end



end
