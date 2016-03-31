# encoding: utf-8
require 'product_recommender'
class VitrinesController < ApplicationController
   before_filter :authorize, :correct_vitrine, only: [:edit, :update]
   before_filter :log_view , only: [:show]

  def show
    @vitrine = Vitrine.find(params[:id])

    if request.path != vitrine_path(@vitrine)
      redirect_to @vitrine, status: :moved_permanently
    end
    canonical_url url_for(@vitrine)
    @total_from_buyers = Feedback.by_participant(@vitrine.user, Feedback::FROM_BUYERS).count
    #  @average_rating_from_buyers = Feedback.average_rating(@vitrine.user, Feedback::FROM_BUYERS)

    @feedbacks = Feedback.by_participant(@vitrine.user, Feedback::FROM_BUYERS).paginate(per_page: 22, page: params[:page]).order('created_at DESC')
    @average_rating_from_buyers = Feedback.average_rating(@vitrine.user, Feedback::FROM_BUYERS)

    @q = Product.joins(:vitrine).where('vitrines.id' => @vitrine.id).ransack(params[:q])
    #  @products = @q.result(distinct: true).paginate(page: params[:page], per_page: 15).order('created_at DESC')

    @products = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)

    # similarities from another vitrines
    ids = ProductRecommender.instance.predictions_for(@vitrine.id, matrix_label: :vitrines)
    @similarities = Product.unscoped.for_ids_with_order(ids)

    # suggestions for current visitor
    ids = ProductRecommender.instance.predictions_for(request.remote_ip, matrix_label: :impressions)
    @suggestions = Product.unscoped.for_ids_with_order(ids)
  end

  def feedbacks
    @vitrine = Vitrine.find(params[:id])
    # @feedbacks = Feedback.by_participant(@vitrine.user, Feedback::FROM_BUYERS).paginate(:per_page => 22, :page => params[:page]).order('created_at DESC')
    @q = Feedback.by_participant(@vitrine.user, Feedback::FROM_BUYERS).ransack(params[:q])
    @feedbacks = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)
    @average_rating_from_buyers = Feedback.average_rating(@vitrine.user, Feedback::FROM_BUYERS)

    respond_to do |format|
      format.html { render 'feedbacks' }
    end
  end

  def new
    @vitrine = Vitrine.new
  end

  def edit
    @vitrine = current_vitrine
  end

  def upvote
    @vitrine = Vitrine.find(params[:id])
    @vitrine.liked_by current_user
    redirect_to :back
  end

  def downvote
    @vitrine = Vitrine.find(params[:id])
    @vitrine.downvote_from current_user
    redirect_to :back
  end

  def tags
    @vitrine = Vitrine.find(params[:id])
    @tags = ActsAsTaggableOn::Tag.where('tags.name LIKE ?', "%#{params[:q]}%")
    respond_to do |format|
      format.json { render json: @tags.collect { |t| { id: t.name, name: t.name } } }
    end
end

  def mark
    @user = current_user
    @vitrine = Vitrine.find(params[:id])
    current_user.mark_as_favorite @vitrine
    redirect_to :back
    end

  def index

    @q = Vitrine.ransack(params[:q])
    @vitrines = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)
  end

  def create
    @vitrine = current_user.build_vitrine(params[:vitrine])
    if @vitrine.save
      redirect_to(action: :edit, id: @vitrine, only_path: true)
      flash[:success] = "#{@vitrine.name} criada com sucesso, boa sorte em seu empreendimento #{@vitrine.user.name}".html_safe

    else
      render :new
    end
  end

  def update
    @vitrine = current_vitrine
    if @vitrine.update_attributes(params[:vitrine])

      redirect_to(action: 'edit', id: @vitrine, format: :html, only_path: true)
      flash[:notice] = "#{@vitrine.name} atualiazada"
    else
      render :edit
    end
  end


  def sales_report
    end_time = Time.now
    @week_stats = prepare_stats(end_time - 6.days, end_time)
    @month_stats = prepare_stats(end_time - 30.days, end_time)

    product_info = current_vitrine.invoices.products_stats(end_time - 30.days..end_time).first
    unless product_info.nil?
      @most_sold_product = Product.find_by_id(product_info.product_id)
      @most_sold_product = ProductData.find_by_id(product_info.product_id) if @most_sold_product.nil?
      week_product_stats = prepare_stats(end_time - 6.days, end_time, product_info.product_id)
      month_product_stats = prepare_stats(end_time - 30.days, end_time, product_info.product_id)

      @week_stats.each do |ws|
        pcount = week_product_stats.find { |s| s['day'] == ws['day'] }
        pcount = pcount.nil? ? 0 : pcount['pcount']
        ws['pcount'] = pcount
      end

      @month_stats.each do |ms|
        pcount = month_product_stats.find { |s| s['day'] == ms['day'] }
        pcount = pcount.nil? ? 0 : pcount['pcount']
        ms['pcount'] = pcount
      end
    end

    (end_time - 6.days).to_date.upto(end_time.to_date) do |date|
      @week_stats << { count: 0, day: date, pcount: 0 } unless @week_stats.any? { |s| s['day'] == date.to_formatted_s(:db) }
    end

    (end_time - 30.days).to_date.upto(end_time.to_date) do |date|
      @month_stats << { count: 0, day: date, pcount: 0 } unless @month_stats.any? { |s| s['day'] == date.to_formatted_s(:db) }
    end
  end



protected

  def log_view
   ip_addr = request.remote_ip
   @vitrine = Vitrine.find(params[:id])
   @views = @vitrine.views.group(:ip_address).size[ip_addr]
   if @views
     if @views >= 1
       return false

     else
       @vitrine.views.create(:ip_address => ip_addr)
     end
   else
     @vitrine.views.create(:ip_address => ip_addr)
   end
  end



  def prepare_stats(start_time, end_time, product_id = nil)
    if product_id.nil?
      current_vitrine.invoices.stats(start_time..end_time).to_a.map(&:serializable_hash)
    else
      Transaction.product_stats(product_id, start_time..end_time).to_a.map(&:serializable_hash)
    end
  end
end
