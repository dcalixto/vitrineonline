# encoding: utf-8
require 'product_recommender'
class ProductsController < ApplicationController
  before_filter :log_impression, only: [:show]
  before_filter :correct_product, only: [:edit, :destroy]

  def index
    @products = Product.search # (params)
  end

  def new
    @product = Product.new
    @genders = Gender.all

    @categories = Category.where('gender_id = ?', Gender.first.id)
    @subcategories = Subcategory.where('category_id = ?', Category.first.id)
  #  @subcategories = Subcategory.all
  end

  # def update_category_select
  #  @catagories = Category.where("gender_id = ?", params[:gender_id])
  #     respond_to do |format|
  #     format.js
  #  end
  # end

  # def update_subcategory_select

  # @subcategories = Subcategory.where("category_id = ?", params[:category_id])
  # respond_to do |format|
  # format.js
  # end
  # end

  def upvote
    @product = Product.find(params[:id])
    @product.liked_by current_user
    redirect_to :back
  end

  def downvote
    @product = Product.find(params[:id])
    @product.downvote_from current_user
    redirect_to :back
  end




  def tags
  @tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?", "%#{params[:q]}%")
  respond_to do |format|
  format.json { render :json => @tags.collect{|t| {:id => t.name, :name => t.name }}}
  end
end

  def edit
    @product = Product.cached_find(params[:id])
  end

  def update
    @product = Product.cached_find(params[:id])
    if @product.update_attributes(params[:product])
      expire_fragment('product_show', 'product')
      redirect_to(action: :show, id: @product, only_path: true)
      flash[:success] = "#{(@product.name)} atualizado"
    else
      render :edit
    end
  end

  def show
    @product = Product.find(params[:id])
    canonical_url url_for(@product)
    @total_feedbacks = Feedback.joins(:product).where('products.id = ?', @product.id).where('buyer_feedback_date is not null').count
    @average_rating_from_buyers = Feedback.joins(:product).where('products.id = ?', @product.id).where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating)

     @colors_for_dropdown = @product.colors.product(:name).collect{ |co| [co.name, co.id]}
  #  @colors_for_dropdown = @product.colors.collect { |co| [co.name, co.id] }
    @sizes_for_dropdown = @product.sizes.collect { |s| [s.size, s.id] }

    @q = Feedback.by_participant(@product, Feedback::FROM_BUYERS).ransack(params[:q])
    @feedbacks = @q.result(distinct: true).paginate(per_page: 22, page: params[:page]) # .product('created_at DESC')

similiar_products = ProductRecommender.instance.similarities_for("product-1")
  end

  def feedbacks
    begin
      @product = Product.find(params[:id])
    rescue
      @product = nil
    end

    unless @product.nil?
      @feedbacks = Feedback.joins(:product).where('products.id = ?', @product.id).where('buyer_feedback_date is not null').paginate(page: params[:page])
      @average_rating_from_buyers = Feedback.joins(:product).where('products.id = ?', @product.id).where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating)
    end

    respond_to do |format|
      format.html { render 'feedbacks', layout: false }
    end
  end

  # def create
  #   @product = current_vitrine.products.build(params[:product])
  #    if @product.save
  #      redirect_to product_build_path(@product, Product.steps.one)
  # flash[:success] = "#{(@product.name)} adicionado"
  #    else
  #      render :new
  #    end
  #  end

  def create
    @product = current_vitrine.products.build(params[:product])
    if @product.save #(validate: false)
      redirect_to wizard_path(steps.first, product_id: @product.id)
    else
      render :new
        end
   end

  def destroy
    @product = Product.find(params[:id])
    Product.tire.index.remove @product
    if @product.destroy
      expire_fragment('product')
      flash[:success] = "#{(@product.name)} removido"
    end
  end

  def autocomplete
    render json: Product.search(params[:query], fields: [{ name: :text_start }], limit: 10).map(&:name)
    end

  def sold_info
    @product_data = ProductData.find(params[:id])
    @last_transaction = Transaction.joins(:product).where('products.product_id = ?', @product_data.id).product('transactions.created_at desc').first
  end

  protected

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
    else
      redirect_to action: :sold_info
    end
  end

  private

  def correct_product
    @product = Product.find(params[:id])
    redirect_to login_path unless current_vitrine?(@product.vitrine)
  end
end
