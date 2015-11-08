module DynamicSelect
  class SubcategoriesController < ApplicationController
    respond_to :json

    def index
      @subcategories = Subcategory.where(:category_id => params[:category_id])
      respond_with(@subcategories)
    end
  end
end
