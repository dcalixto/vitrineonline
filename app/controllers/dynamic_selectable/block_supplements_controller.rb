#encoding: utf-8
module DynamicSelectable
  class BlockSupplementsController < SelectController
    def index
      supplements = Supplement.where(block_id: params[:block_id]).select('id, name').order('name asc')
      render json: supplements
    end
  end
end

