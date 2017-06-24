module DynamicSelectable
  class BlockSportsController < SelectController
    def index
      sports = Sport.where(block_id: params[:block_id]).select('id, category').order('name asc')
      render json: sports
    end
  end
end

