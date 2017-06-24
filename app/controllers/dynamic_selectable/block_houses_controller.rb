module DynamicSelectable
  class BlockHousesController < SelectController
    def index
      houses = House.where(block_id: params[:block_id]).select('id, category').order('name asc')
      render json: houses
    end
  end
end

