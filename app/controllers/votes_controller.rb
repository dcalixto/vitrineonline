# encoding: utf-8
require 'will_paginate/array'
class VotesController < ApplicationController
  before_filter :authorize, :correct_user, only: [:create, :edit, :update, :destroy]
  def products
     
 
 @products = @user.find_up_voted_items.paginate(page: params[:page], per_page: 22)
 
  end

  def vitrines
    @vitrines = Vitrine.where(current_user.id).where(current_user.id).find_with_reputation(:votes, :all, conditions: ['votes = ?', 1.0]).paginate(page: params[:page], per_page: 22)
  end


  def users
    @users = ReputationSystem::Evaluation.where(reputation_name: :votes).where('value < 0').includes(:source).map(&:source).paginate(page: params[:page], per_page: 22)
  end




end
