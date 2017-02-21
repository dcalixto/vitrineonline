module GenderHelper
  def fetch_genders
    genders =  $redis.get("genders")
    if genders.nil?
      genders = Gender.all.to_json
      $redis.set("genders", genders)
      # Expire the cache, every 3 hours
      $redis.expire("genders",3.hour.to_i)
    end
    @genders = JSON.load genders
  end
end

