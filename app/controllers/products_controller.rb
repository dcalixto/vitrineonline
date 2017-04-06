# encoding: utf-8

require 'product_recommender'


class ProductsController < ApplicationController
  before_filter :log_impression, only: [:show]
  before_filter :correct_product, only: [:edit, :destroy]
  before_filter :authorize_vitrine, only: [:create, :edit, :update]

  include ProductsHelper 


  def index
    @products = Product.aggs_search(params)
    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)
 

 
 

  end

  def new
    @product = Product.new
    @genders = Gender.all
    @categories = Category.where('gender_id = ?', Gender.first.id)
    @subcategories = Subcategory.where('category_id = ?', Category.first.id)
   @brands = Brand.all

 @conditions = Condition.all

 @materials = Material.all


    @product = current_vitrine.products.build(params[:product])
          
  end

  def upvote
    @product = Product.cached_find(params[:id])
    @product.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @product = Product.cached_find(params[:id])
    @product.downvote_by current_user
    redirect_to :back
  end





  #TODO
  #report



  def tags


    @products = Product.tagged_with(params[:tag]).where(vitrine_id: params[:vitrine]).paginate(per_page: 20, page: params[:page])
  end

  def edit
    @product = Product.cached_find(params[:id])
  end

  def update
    @product = Product.find(params[:id])




    respond_to do |format|
      format.html do
        if @product.update_attributes(params[:product])
         Product.reindex

          redirect_to(action: :show, id: @product, only_path: true)
          flash[:success] = "#{@product.name} atualizado"
        else
          render :edit
        end
      end
      format.json do
        if params[:images] && params[:images][:ifoto]
          params[:images][:ifoto].values.each do |ifoto|
            image = @product.images.build
            image.ifoto = ifoto
            image.save
          end
        end
        render :nothing => true
      end
    end
  end
  
  def show
    @product = Product.cached_find(params[:id])
@user =  Proback.where('user_id IS NOT NULL')


canonical_url url_for(@product)
  

    @colors_for_dropdown = @product.colors.collect{ |co| [co.name, co.id]}


    @sizes_for_dropdown = @product.sizes.collect { |s| [s.size, s.id] }

 #   @q = Feedback.by_participant(@product, Feedback::FROM_BUYERS).ransack(params[:q])
  
 #  @q = Feedback.joins(:product).where('products.id = ?', @product.id).where('buyer_feedback_date is not null').ransack(params[:q])
    
  # @feedbacks = @q.result(distinct: true).paginate(per_page: 22, page: params[:page])



  @q = Proback.joins(:product,:user).where('products.id = ? and users.id = ?', @product.id, @user.id).ransack(params[:q])
    
  



  
  @probacks = @q.result(distinct: true).paginate(per_page: 22, page: params[:page])




    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)

    # similarities for current product
    ids = ProductRecommender.instance.similarities_for(@product.id)
    @similarities = Product.unscoped.for_ids_with_order(ids)

    # similarities for current product in product's vitrine (same ids but filter by vitrine)
    @similarities_for_vitrine = Product.unscoped.where(vitrine_id: @product.vitrine_id).for_ids_with_order(ids)




 
      
      
 
  end

  def feedbacks
    begin
      @product = Product.cached_find(params[:id])
    rescue
      @product = nil
    end

    unless @product.nil?

      @q = Feedback.joins(:product).where('products.id = ?', @product.id).where('buyer_feedback_date is not null').ransack(params[:q])
      @feedbacks = @q.result(distinct: true).paginate(per_page: 22, page: params[:page])

      @average_rating_from_buyers = Feedback.joins(:product).where('products.id = ?', @product.id).where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating)
    end
  end


  def create
    @product = current_vitrine.products.build(params[:product])
         if @product.save
      
    redirect_to product_step_path(@product.id, Product.form_steps.first, :product_id => @product.id, only_path: true, format: :html)
    else
      render :new, format: :html
    end
  end


  def views
    @product = Product.cached_find(params[:id])
    # chart data
    end_time = Time.now
    @week_stats = prepare_stats(end_time - 6.days, end_time)
    @month_stats = prepare_stats(end_time - 30.days, end_time)




  end




  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      Product.reindex
      expire_fragment('product')
      flash[:success] = "#{@product.name} removido"
    end
  end

  def autocomplete
    render json: Product.search(params[:query], fields: [{ name: :text_start }], limit: 4).map(&:name)
  end

  def omniauth_callback
    cookies[params[:provider] + '_auth_token'] = { value: params[:access_token]}
    render :nothing => true
  end

  protected

  def sold_info
    @product_data = ProductData.find(params[:id])
    @last_transaction = Transaction.joins(:product).where('products.product_id = ?', @product_data.id).product('transactions.created_at desc').first
  end

  def log_impression
    begin
      @product = Product.cached_find(params[:id])
    rescue
      @product = nil
    end
    if @product.present?
      ip_addr = request.remote_ip
      @impressions = @product.impressions.group(:ip_address).size[ip_addr]
      if @impressions
        if @impressions >= 1
          return false
        else
          @product.impressions.create(ip_address: ip_addr)
        end
      else
        @product.impressions.create(ip_address: ip_addr)
      end
    end
  end



  def prepare_stats(start_time, end_time)
    @product = Product.cached_find(params[:id])

    result = @product.impressions.stats(start_time..end_time).to_a.map(&:serializable_hash)
    start_time.to_date.upto(end_time.to_date) do |date|
      result << { count: 0, day: date } unless result.any? { |s| s['day'] == date.to_formatted_s(:db) }
    end
    result
  end



  private

  def correct_product
    @product = Product.cached_find(params[:id])
    redirect_to login_path unless current_vitrine?(@product.vitrine)
  end


end
