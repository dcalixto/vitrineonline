# encoding: utf-8
class FavoritesController < ApplicationController
  def products
    @q = current_user.favorite_products.ransack(params[:q])
    @favorite_products = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)
  end

  def vitrines
  #  @q = current_user.find_liked_items.ransack(params[:q])
#  current_user.find_liked_items = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)
  end




end
