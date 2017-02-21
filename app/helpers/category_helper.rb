module CategoryHelper
  def fetch_categories
    categories =  $redis.get("categories")
    if categories.nil?
      categories = Category.all.to_json
      $redis.set("categories", categories)
      # Expire the cache, every 3 hours
      $redis.expire("categories",3.hour.to_i)
    end
    @categories = JSON.load categories
  end
end
