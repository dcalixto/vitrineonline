module DynamicSelectable
  class GenderCategoriesController < SelectController
    def index
      categories = Category.where(gender_id: params[:gender_id]).select('id, name').order('name asc')
      render json: categories
    end
  end
end
