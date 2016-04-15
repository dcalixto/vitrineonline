# encoding: utf-8
class CategoriesController < ApplicationController
  def show
    @category = Category.cached_find(params[:id])
    @products = Product.aggs_search(params.merge(category_id: @category.id))

    end

  def links
    respond_to do |format|
      format.html { render 'links', layout: false }
    end
     end
end
