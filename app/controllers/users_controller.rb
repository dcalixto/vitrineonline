# encoding: utf-8

class UsersController < ApplicationController
  before_filter :authorize, :correct_user, only: [:edit, :update, :destroy]
  #caches_action :edit, layout: false



  def show
    @user = User.find(params[:id])
    canonical_url url_for(@user)

    @total_from_sellers = Feedback.by_participant(@user, Feedback::FROM_SELLERS).count
    @average_rating_from_sellers = Feedback.average_rating(@user, Feedback::FROM_SELLERS)
    # @feedbacks = Feedback.by_participant(@user, Feedback::FROM_SELLERS).paginate(:per_page => 22, :page => params[:page]).order('created_at DESC')

    @q = Feedback.by_participant(@user, Feedback::FROM_SELLERS).ransack(params[:q])
    @feedbacks = @q.result(distinct: true).paginate(per_page: 22, page: params[:page]).order('created_at DESC')
  end

  def feedbacks
    @user = User.find(params[:id])
    # @feedbacks = Feedback.by_participant(@user, Feedback::FROM_SELLERS).paginate(:per_page => 22, :page => params[:page]).order('created_at DESC')

    @q = Feedback.by_participant(@user, Feedback::FROM_SELLERS).ransack(params[:q])
    @feedbacks = @q.result(distinct: true).paginate(per_page: 22, page: params[:page])
    @average_rating_from_sellers = Feedback.average_rating(@user, Feedback::FROM_SELLERS)
    respond_to do |format|
      format.html { render 'feedbacks'}
    end
  end


 def links
    @user = User.find(params[:id])

  if current_user.cart
       @orders = current_user.cart.orders.where('status = ?', params[:status] || Order.statuses[0])
    
        end 


      respond_to do |format|
      format.html { render 'links', :layout=> false}
    end
  end


def index
  @users = User.all.paginate(per_page: 22, page: params[:page])
end

  def new
    @user = User.new
    @vitrine = Vitrine.new
  end

  def create
    @user = User.new(params[:user])
    @vitrine = Vitrine.new(params[:vitrine])

    if @user.save
      @user.authenticate(params[:user][:password])

      @user.update_attribute(:login_at, Time.zone.now)
      @user.update_attribute(:ip_address, request.remote_ip)
      cookies[:auth_token] = { value: @user.auth_token, expires: 3.month.from_now, secure: !(Rails.env.test? || Rails.env.development?) }
      redirect_to root_url
      flash[:success] = "Bem vindo a Vitrineonline #{(@user.name)}".html_safe
    else
      render :new
    end
  end

  def edit
    @user = current_user

    @states = State.all
    @cities = City.where('state_id = ?', State.first.id)
  end

  def update_city_select
    @cities = City.where('state_id = ?', params[:state_id])
    respond_to do |format|
      format.js
    end
  end

 

  def products
    @vitrine = Vitrine.find(params[:id])

    @q = @vitrine.products.ransack(params[:q])
    @products = @q.result.paginate(page: params[:page], per_page: 1)

    respond_to do |format|
      format.html { render 'products', layout: false }
    end
  end

  def update
    @user = User.find(params[:id])
     @states = State.all
    @cities = City.where('state_id = ?', State.first.id)
    if @user.update_attributes(params[:user])
      redirect_to(action: :edit, id: @user, only_path: true)
      flash[:notice] = 'Conta atualiazada'
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      cookies.delete(:auth_token)
      redirect_to root_path
      flash[:success] = 'Conta deletada'
    else
      render :edit
    end
  end
end
