# encoding: utf-8
require 'will_paginate/array'
class ApplicationController < ActionController::Base
  protect_from_forgery



 has_mobile_fu

  include SessionsHelper
  include VitrinesHelper
  include AnnouncementsHelper


 before_filter :strict_transport_security
  def strict_transport_security
    if request.ssl?
      response.headers['Strict-Transport-Security'] = "max-age=31536000; includeSubDomains"
    end
  end

   before_filter :no_store_cache#, if: :is_prod?
  after_filter :no_store_cache#, if: :is_prod?

     #def is_prod?
      #      Rails.env.production?
      # end

     def no_store_cache#(max_age = 5.minutes.to_s)
       response.headers['Cache-Control'] = "max-age=0, no-cache, no-store, must-revalidate"
       response.headers['Pragma'] = "no-cache"
       response.headers['Expires'] = "-1"
       #response.headers['Surrogate-Control'] = "max-age=#{max_age}"
       #response.headers['Content-Security-Policy'] = "default-src *; script-src http://localhost:3000/assets/; style-src http://localhost:3000/assets/"
     end


    # def set_cache_control_headers(max_age = 5.minutes.to_s)
    #     response.headers['Cache-Control'] = 'public, no-cache, max-age=0'
    #     response.headers['Surrogate-Control'] = "max-age=#{max_age}"
    # end


after_filter :set_online

    # set to online
private

def set_online
      if !!current_user
        # using separate Redis database
        # such as $redis_onlines = Redis.new db: 15
        # value not need, only key
        $redis_onlines.set( current_user.id, nil, ex: 10*60 )
        # 'ex: 10*60' - set time to live - 10 minutes
      end
    end

 # USER HELPERS


  def current_user
    @current_user ||= User.first(conditions: ['auth_token = :token or oauth_token = :token', { token: cookies[:auth_token] }]) if cookies[:auth_token]
  end

  helper_method :current_user
  helper_method :current_vitrine
  helper_method :vitrine
  helper_method :current_announcement

  def authorize
    if current_user.nil?
      redirect_to login_url
      flash[:alert] = 'Você precisa logar'
    end
  end

  def authorize_vitrine
    if current_vitrine.nil?
      redirect_to login_url
      flash[:alert] = 'Você precisa criar sua vitrine'
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  attr_writer :current_user

  def current_user?(user)
    user == current_user
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to login_path unless current_user?(@user)
  end

  # FLASH MESSAGES

  after_filter :flash_to_headers

  def flash_to_headers
    return unless request.xhr?
    response.headers['X-Message'] = flash_message
    response.headers['X-Message-Type'] = flash_type.to_s

    flash.discard # don't want the flash to appear when you reload page
  end

  def flash_message
    [:error, :alert, :notice, :success].each do |type|
      return flash[type] unless flash[type].blank?
    end
  end

  def flash_type
    [:error, :alert, :notice, :success].each do |type|
      return type unless flash[type].blank?
    end
  end

  # FILTERS
  before_filter :load_categories, :banned?

  protected

  def load_categories
    @genders = Gender.includes(:categories).all
    @categories = Category.includes(:subcategories).all
  end

  def banned?
    if current_user.present? && current_user.banned?
      remove_user
      flash[:error] = 'Esta conta foi banida por violar os termos de uso e privacidade'
    end
  end






end
