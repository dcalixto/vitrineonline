module SubcategoryHelper
  def fetch_subcategories
    subcategories =  $redis.get("subcategories")
    if subcategories.nil?
      subcategories = Subcategory.all.to_json
      $redis.set("subcategories", subcategories)
      # Expire the cache, every 3 hours
      $redis.expire("subcategories",3.hour.to_i)
    end
    @subcategories = JSON.load subcategories
  end
end
