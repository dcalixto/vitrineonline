 #encoding: utf-8
class Categories::SubcategoriesController < ApplicationController
  def show
    @subcategory = Subcategory.cached_find(params[:id])
    @products =  Product.aggs_search(params.merge(subcategory_id: @subcategory.id))
  end
end
