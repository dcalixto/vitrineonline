 #encoding: utf-8
module DynamicSelectable
  class CategorySubcategoriesController < SelectController
    def index
      subcategories = Subcategory.where(category_id: params[:category_id]).select('id, name').order('name asc')
      render json: subcategories
    end
  end
end
