class Categories::SubcategoriesController < ApplicationController
  def show
    @subcategory = Subcategory.find(params[:id])
    @products =  Product.search(params.merge(subcategory_id: @subcategory.id))
  end
end
