# encoding: utf-8
class StocksController < ApplicationController
  before_filter :authorize_vitrine,  only: [:index, :destroy]

  def index
    @q = Product.joins(:vitrine).where('vitrines.id' => current_vitrine.id).ransack(params[:q])
    @products = @q.result(distinct: true).includes(:images).paginate(page: params[:page], per_page: 22)
      end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to :back
      flash[:success] = "#{@product.name} removido"
    end
  end
end
