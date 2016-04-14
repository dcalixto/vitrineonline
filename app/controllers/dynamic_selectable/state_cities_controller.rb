#encoding: utf-8
module DynamicSelectable
 class StateCitiesController < SelectController
   def index
     cities = City.where(state_id: params[:state_id]).select('id, name').order('name asc')
     render json: cities
   end
 end
end
