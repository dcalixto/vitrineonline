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
    #  @genders = Gender.all


    @blocks = Block.all
    @genders = Gender.where('block_id = ?', Block.first.id)
    @categories = Category.where('gender_id = ?', Gender.first.id)
    @subcategories = Subcategory.where('category_id = ?', Category.first.id)
    @eletronics = Eletronic.where('block_id = ?', Block.first.id)
    @supplements = Supplement.where('block_id = ?', Block.first.id)
    @sports = Sport.where('block_id = ?', Block.first.id)
    @foods = Food.where('block_id = ?', Block.first.id)

    @tools = Tool.where('block_id = ?', Block.first.id)
    @houses = House.where('block_id = ?', Block.first.id)
    @arts = Art.where('block_id = ?', Block.first.id)
    @books = Book.where('block_id = ?', Block.first.id)
    @virtuals = Virtual.where('block_id = ?', Block.first.id)


    @brands = Brand.all
    @conditions = Condition.all
    @materials = Material.all
    @product = current_vitrine.products.build(params[:product])




 # creating data arrays for selects
    @blocks = Block.all
    @blocks_for_dropdown = []
    @blocks.each do |i|
      @blocks_for_dropdown << [i.category, i.id]
    end




 # creating data arrays for selects
    @genders = Gender.all
    @genders_for_dropdown = []
    @genders.each do |i|
      @genders_for_dropdown << [i.gender, i.id, {class: i.block.id}]
    end




    # creating data arrays for selects
    @categories = Category.all
    @categories_for_dropdown = []
    @categories.each do |i|
      @categories_for_dropdown << [i.name, i.id, {class: i.gender.id}]
    end

    @subcategories = Subcategory.all
    @subcategories_for_dropdown = []
    @subcategories.each do |i|
      # class of dependent option must be equal to id of parent one
      @subcategories_for_dropdown << [i.name, i.id, {class: i.category.id}]
    end






# creating data arrays for selects
    @eletronics = Eletronic.all
    @eletronics_for_dropdown = []
    @eletronics.each do |i|
    @eletronics_for_dropdown << [i.item, i.id, {class: i.block.id}]
    end




# creating data arrays for selects
    @supplements = Supplement.all
    @supplements_for_dropdown = []
    @supplements.each do |i|
    @supplements_for_dropdown << [i.name, i.id, {class: i.block.id}]
    end


# creating data arrays for selects
    @sports = Sport.all
    @sports_for_dropdown = []
    @sports.each do |i|
    @sports_for_dropdown << [i.category, i.id, {class: i.block.id}]
    end


# creating data arrays for selects
    @autos = Auto.all
    @autos_for_dropdown = []
    @autos.each do |i|
    @autos_for_dropdown << [i.item, i.id, {class: i.block.id}]
    end




# creating data arrays for selects
    @tools = Tool.all
    @tools_for_dropdown = []
    @tools.each do |i|
    @tools_for_dropdown << [i.name, i.id, {class: i.block.id}]
    end







# creating data arrays for selects
    @houses = House.all
    @houses_for_dropdown = []
    @houses.each do |i|
    @houses_for_dropdown << [i.name, i.id, {class: i.block.id}]
    end


# creating data arrays for selects
    @foods = Food.all
    @foods_for_dropdown = []
    @foods.each do |i|
    @foods_for_dropdown << [i.name, i.id, {class: i.block.id}]
    end





# creating data arrays for selects
    @arts = Art.all
    @arts_for_dropdown = []
    @arts.each do |i|
    @arts_for_dropdown << [i.name, i.id, {class: i.block.id}]
    end


# creating data arrays for selects
    @books = Book.all
    @books_for_dropdown = []
    @books.each do |i|
    @books_for_dropdown << [i.name, i.id, {class: i.block.id}]
    end






    # creating data arrays for selects
    @virtuals = Virtual.all
    @virtuals_for_dropdown = []
    @virtuals.each do |i|
    @virtuals_for_dropdown << [i.name, i.id, {class: i.block.id}]
    end




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

    canonical_url url_for(@product)


    @colors_for_dropdown = @product.colors.collect{ |co| [co.name, co.id]}


    @sizes_for_dropdown = @product.sizes.collect { |s| [s.size, s.id] }


    #byebug
    @q = Proback.joins(:product).where('products.id = ?', @product.id).ransack(params[:q])
    @probacks = @q.result(distinct: true).includes(:user).paginate(per_page: 22, page: params[:page]).order('created_at DESC')


    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)

    # similarities for current product
    ids = ProductRecommender.instance.similarities_for(@product.id)
    @similarities = Product.unscoped.for_ids_with_order(ids)

    # similarities for current product in product's vitrine (same ids but filter by vitrine)
    @similarities_for_vitrine = Product.unscoped.where(vitrine_id: @product.vitrine_id).for_ids_with_order(ids)



  end

  def probacks

    @product = Product.find(params[:id])

    @q = Proback.joins(:product).where('products.id = ?', @product.id).ransack(params[:q])
    @probacks = @q.result(distinct: true).includes(:user).paginate(per_page: 22, page: params[:page]).order('created_at DESC')

    # @probacks =  Proback.joins(:product).where('products.id = ?', @product.id)#.paginate(:per_page => 22, :page => params[:page])
    # @probacks = Proback.by_participant(@product.boutique.user, Feedback::FROM_SELLERS).paginate(:page => params[:page])



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
    @product = Product.cached_find(params[:id])
    # this assumes you have a current_user method in your authentication system
    @product.impressions.create(ip_address: request.remote_ip)
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
