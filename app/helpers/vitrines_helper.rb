# encoding: utf-8
module VitrinesHelper
include ActsAsTaggableOn::TagsHelper
  def current_vitrine
    @current_vitrine ||= current_user.vitrine
  end

  def current_vitrine?(vitrine)
    vitrine == current_vitrine
  end

  def vitrine
    vitrine = Vitrine.find_by_id(params[:id])
  end

  def current_vitrine=(vitrine)
    @current_vitrine = vitrine
  end

  def correct_vitrine
    @vitrine = Vitrine.find(params[:id])
    redirect_to login_path unless current_vitrine?(@vitrine)
  end

  def current_seller
    @current_seller ||= current_vitrine.orders
 
  end

 def order
    orders = Order.find_by_id(params[:id])
  end


 def branded
 @current_vitrine.branded
 end



  def fetch_vitrines
    vitrines =  $redis.get("vitrines")
    if vitrines.nil?
      vitrines = Vitrine.all.to_json
      $redis.set("vitrines", vitrines)
      # Expire the cache, every 3 hours
      $redis.expire("vitrines",3.hour.to_i)
    end
    @vitrines = JSON.load vitrines
  end

  
end
