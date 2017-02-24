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

  #  @image =  @product.images.build


         @product = current_vitrine.products.build(params[:product])
 @image = @product.images.build
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
      # format.html do
      if @product.update_attributes(params[:product])
        Product.reindex

        redirect_to(action: :show, id: @product, only_path: true)
        flash[:success] = "#{@product.name} atualizado"
      else
        render :edit
      end
    end
    #format.json do
    #  if params[:images] && params[:images][:ifoto]
    #   params[:images][:ifoto].values.each do |ifoto|
    #     image = @product.images.build
    #     image.ifoto = ifoto
    #     image.save
    #   end
    #  end
    #  render :nothing => true
    #  end
    # end
  end

  def show
    @product = Product.cached_find(params[:id])

    canonical_url url_for(@product)
    @total_feedbacks = Feedback.joins(:product).where('products.id = ?', @product.id).where('buyer_feedback_date is not null').count


    @average_rating_from_buyers = Feedback.joins(:product).where('products.id = ?', @product.id).where('buyer_feedback_date is not null').rated(Feedback::FROM_BUYERS).average(:buyer_rating)

    @colors_for_dropdown = @product.colors.collect{ |co| [co.name, co.id]}


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
 #@images = @product.images.build


 
 

    respond_to do |format|
     format.html do

 
        if @product.save



  params[:images]['ifoto'].each do |k, a|
          @image = @product.images.create!(:ifoto => a.pop)
  end

   

   @product.create_activity :create, owner: current_vitrine
          #facebook sharing
          Product.reindex
          if @product.is_shared_on_facebook
            begin
              client = Koala::Facebook::API.new cookies[:facebook_auth_token]
              options = {
                :name => @product.name,
                :link => product_url(@product),
                :caption => "#{current_user.full_name} postou um produto",
                :description => @product.detail || ''
              }
              options[:picture] = (root_url[0...-1] + @product.images.first.ifoto.url(:big)) if @product.images.length > 0
              client.put_wall_post("#{@product.name}", options)
            rescue StandardError => e
              logger.error e.message
              @product.update_attribute :is_shared_on_facebook, false
            end
          end

          #twitter sharing
          if @product.is_shared_on_twitter
            begin
              client = Twitter::REST::Client.new do |config|
                config.consumer_key        = ENV['TWITTER_API_KEY']
                config.consumer_secret     = ENV['TWITTER_API_SECRET']
                config.access_token        = cookies[:twitter_auth_token]
                config.access_token_secret = cookies[:twitter_auth_secret]
              end

              status = "Olá! adicicionei um novo produto '#{@product.name}': #{product_url(@product)}"
              if @product.images.length > 0
                client.update_with_media status, File.new(@product.images.first.ifoto.path)
              else
                client.update status
              end
            rescue StandardError => e
              logger.error e.message
              @product.update_attribute :is_shared_on_twitter, false
            end
          end
          redirect_to order_stocks_path(current_vitrine.id)
        else
          render :new, format: :html
        end
           end
     format.json do

         render :nothing => true


       # @product = current_vitrine.products.build(params[:product])
 #image = @product.images.build(params[:images])


   #   end
    #  if @product.save
     #   if params[:images] && params[:images][:ifoto]
      #    params[:images][:ifoto].values.each do |ifoto|

       #            image.ifoto = ifoto
       #     image.save
     end
    # render :nothing => true

         end
                # end
  #   end
    #end

  
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
