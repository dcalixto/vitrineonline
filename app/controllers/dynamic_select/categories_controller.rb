module DynamicSelect
  class CategoriesController < ApplicationController
    respond_to :json

    def index
      @categories = Category.where(:gender_id => params[:gender_id])
      respond_with(@categories)
    end
  end
end
