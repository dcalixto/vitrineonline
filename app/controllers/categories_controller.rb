# encoding: utf-8
class CategoriesController < ApplicationController


  include CategoryHelper 
  def show
    @category = Category.find(params[:id])
    @products = Product.aggs_search(params.merge(category_id: @category.id))
    #  if request.path != category_path(@category)
    #   redirect_to @category, status: :moved_permanently
    #end

    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)

  end



end
