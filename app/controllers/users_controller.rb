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

    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)

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



def index
  #@q = User.ransack(params[:q])
  #@users = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)

 @users = User.search_by_name(params[:name]).page(params[:page]).per_page(22)
end

#def set_search
#
#  @q = User.ransack(params[:q])
#  @users = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)
#    render 'index'
#  end


  def new
    @user = User.new
    @vitrine = Vitrine.new
  end

  def create
    @user = User.new(params[:user])
    @vitrine = Vitrine.new(params[:vitrine])

    if @user.save
      UserMailer.registration_confirmation(@user).deliver
    redirect_to root_url

      flash[:success] = "Por favor confirme seu endereço de email para continuar".html_safe
    else

      render :new
      flash[:error] = "Ooooppss, algo deu errado!".html_safe
    end
  end


  def confirm_email
      user = User.find_by_confirm_token(params[:id])
      if user
        user.email_activate
        flash[:success] = "Bem vindo a Vitrineonline #{(@user.name)}! Seu email foi confirmado.
        Por favor logue para continuar.".html_safe
        redirect_to login_url
      else
        flash[:error] = "Desculpa. Usuário inexistente"
        redirect_to root_url
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
    @products = @q.result.paginate(page: params[:page], per_page: 22)

    respond_to do |format|
      format.html { render 'products', layout: false }
    end
  end

  def update
    @user = User.find(params[:id])
     @states = State.all
    @cities = City.where('state_id = ?', State.first.id)
    if @user.update_attributes(params[:user])
      redirect_to(action: :edit, id: @user, only_path: true, render nothing: true, format: :html)
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
