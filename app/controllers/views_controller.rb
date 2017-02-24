# encoding: utf-8
class ViewsController < ApplicationController
  before_filter :authorize_vitrine, only: [:index]

  before_filter :log_impression, only: [:show]

  def index
    @q = Product.joins(:vitrine).where('vitrines.id' => current_vitrine.id).ransack(params[:q])
    @products = @q.result(distinct: true).includes(:images).paginate(page: params[:page], per_page: 20)
    # chart data
    end_time = Time.now
    @week_stats = prepare_stats(end_time - 6.days, end_time)
    @month_stats = prepare_stats(end_time - 30.days, end_time)
  end




  protected

  def prepare_stats(start_time, end_time)
    result = current_vitrine.impressions.stats(start_time..end_time).to_a.map(&:serializable_hash)
    start_time.to_date.upto(end_time.to_date) do |date|
      result << { count: 0, day: date } unless result.any? { |s| s['day'] == date.to_formatted_s(:db) }
    end
    result
  end






end
