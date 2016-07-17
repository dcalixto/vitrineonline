# encoding: utf-8
# require 'product_recommender'
class UsersController < ApplicationController
  before_filter :authorize, :correct_user, only: [:edit, :update, :destroy]
  cache_sweeper :user_sweeper

  def show
    @user = User.cached_find(params[:id])
    canonical_url url_for(@user)

    @total_from_sellers = Feedback.by_participant(@user, Feedback::FROM_SELLERS).count
    @average_rating_from_sellers = Feedback.average_rating(@user, Feedback::FROM_SELLERS)
      @q = Feedback.by_participant(@user, Feedback::FROM_SELLERS).ransack(params[:q])
    @feedbacks = @q.result(distinct: true).paginate(per_page: 22, page: params[:page])    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)

    @products = Product.paginate(page: params[:page], per_page: 22)
    @vitrines = Vitrine.paginate(page: params[:page], per_page: 22)
 
  
  end

  def user_feedbacks
    @user = User.cached_find(params[:id])

    @q = Feedback.by_participant(@user, Feedback::FROM_SELLERS).ransack(params[:q])
    @feedbacks = @q.result(distinct: true).paginate(per_page: 22, page: params[:page])
    @average_rating_from_sellers = Feedback.average_rating(@user, Feedback::FROM_SELLERS)
    respond_to do |format|
      format.html { render 'feedbacks' }
    end
  end

  def message_user
    @user = User.cached_find(params[:id])

    respond_to do |format|
      format.html { render 'message_user' }
    end
  end

  def new
    @user = User.new
    @vitrine = Vitrine.new
  end

  def create
    @user = User.new(params[:user])
    @vitrine = Vitrine.new(params[:vitrine])

    if @user.save
      UserMailer.registration_confirmation(:user_id).deliver
      redirect_to root_url

      flash[:success] = "Por favor confirme seu endereço de email para continuar".html_safe
    else

      render :new
      flash[:error] = 'Ooooppss, algo deu errado!'.html_safe
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Bem vindo a Vitrineonline  Seu email foi confirmado.
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

  def products

 @products = @user.find_up_voted_items.paginate(page: params[:page], per_page: 22)

 

     end

  def vitrines

 @vitrines = @user.find_up_voted_items.paginate(page: params[:page], per_page: 22)

 

     end



 

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      format.html do
        @states = State.all
        @cities = City.where('state_id = ?', State.first.id)
        if @user.update_attributes(params[:user])
          redirect_to(action: :edit, id: @user, only_path: true, format: :html)
          flash[:notice] = 'Conta atualiazada'

        else
          render :edit
        end
      end
      format.json do
        @user.update_attributes(params[:user])
        render nothing: true
      end
    end
  end

  def destroy
    if @user.destroy
      Product.reindex
      cookies.delete(:auth_token)
      redirect_to root_path
      flash[:success] = 'Conta deletada'
    else
      render :edit
    end
  end









end
