# encoding: utf-8
  require 'will_paginate/array'
class FavoritesController < ApplicationController
  def products
    #@q = current_user.favorite_products.ransack(params[:q])
   # @favorite_products = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)


@product_likes = current_user.find_up_voted_items.paginate(:page => params[:page], :per_page => 22)

  end

  def vitrines



       @user_likes = current_user.find_liked_items.paginate(:page => params[:page], :per_page => 22)


  #  @q = @user_likes.ransack(params[:q])
 #@user_likes  = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)


  end




end
