# encoding: utf-8
class GendersController < ApplicationController
  def show
    @gender = Gender.find(params[:id])
    @products = Product.aggs_search(params.merge(gender_id: @gender.id))
    if request.path != gender_path(@gender)
      redirect_to @gender, status: :moved_permanently
    end
  end

end
