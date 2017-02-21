 #encoding: utf-8
class Categories::SubcategoriesController < ApplicationController
 
  include SubcategoryHelper
  
  def show
    @subcategory = Subcategory.cached_find(params[:id])
    @products =  Product.aggs_search(params.merge(subcategory_id: @subcategory.id))
 
  
  ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)
  end
end
