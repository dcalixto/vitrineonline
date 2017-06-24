#encoding: utf-8
module DynamicSelectable
  class BlockGendersController < SelectController
    def index
      genders = Gender.where(block_id: params[:block_id]).select('id, gender').order('gender asc')
      render json: genders
    end
  end
end





