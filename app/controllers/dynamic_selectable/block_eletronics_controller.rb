#encoding: utf-8
module DynamicSelectable
  class BlockEletronicsController < SelectController
    def index
      eletronics = Eletronic.where(block_id: params[:block_id]).select('id, item').order('item asc')
      render json: eletronics
    end
  end
end

