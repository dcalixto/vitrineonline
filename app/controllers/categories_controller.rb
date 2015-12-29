# encoding: utf-8
class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = Product.aggs_search(params.merge(category_id: @category.id))

      if request.path != category_path(@category)
      redirect_to @category, status: :movido
     end
    end
end
