# encoding: utf-8
class GendersController < ApplicationController

  include GenderHelper


  def show
    @gender = Gender.find(params[:id])
    @products = Product.aggs_search(params.merge(gender_id: @gender.id))
    if request.path != gender_path(@gender)
      redirect_to @gender, status: :moved_permanently
    end

    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)

  end

end
