# encoding: utf-8
class ProductsController < ApplicationController
  before_filter :log_impression, only: [:show]
  before_filter :correct_product, only: [:edit, :destroy]
#cache_sweeper :product_sweeper
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
  end


 def vote
   value = params[:type] == "Curtir" ? 1 : 0
 @product = Product.find(params[:id])
 @product.add_or_update_evaluation(:votes, value, current_user)
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
    canonical_url url_for(@product)
    @total_feedbacks = Feedback.joins(:product).where('products.id = ?', @product.id).where('buyer_feedback_date is not null').count
    @average_rating_from_buyers = Feedback.joins(:product).where('products.id = ?', @product.id).where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating)

    #   @colors_for_dropdown = @product.colors.product(:name).collect{ |co| [co.name, co.id]}
    @colors_for_dropdown = @product.colors.collect { |co| [co.name, co.id] }
    @sizes_for_dropdown = @product.sizes.collect { |s| [s.size, s.id] }

    @q = Feedback.by_participant(@product, Feedback::FROM_BUYERS).ransack(params[:q])
    @feedbacks = @q.result(distinct: true).paginate(per_page: 22, page: params[:page])

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
      # redirect_to wizard_path(steps.first, product_id: @product.id)
      redirect_to product_step_path(@product, Product.form_steps.first, only_path: true, format: :html)

    else
      render :new, format: :html
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      expire_fragment('product')
      flash[:success] = "#{@product.name} removido"
    end
  end

  def autocomplete
    render json: Product.search(params[:query], fields: [{ name: :text_start }], limit: 4).map(&:name)
    end

  def omniauth_callback
    cookies[params[:provider] + '_auth_token'] = { value: params[:access_token], secure: !(Rails.env.test? || Rails.env.development?) }
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

  private

  def correct_product
    @product = Product.cached_find(params[:id])
    redirect_to login_path unless current_vitrine?(@product.vitrine)
  end


end
