# encoding: utf-8
require 'will_paginate/array'
class VotesController < ApplicationController
  
  before_filter :authorize
  def products
  

@products = Product.where(current_user.id).find_with_reputation(:votes, :all, {:conditions => ["votes = ?", 1.0]}).paginate(page: params[:page], per_page: 22)
  end

  def vitrines
   @vitrines = Vitrine.where(current_user.id).where(current_user.id).find_with_reputation(:votes, :all, {:conditions => ["votes = ?", 1.0]}).paginate(page: params[:page], per_page: 22)





  end
end
