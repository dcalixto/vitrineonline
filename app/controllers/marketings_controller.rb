# encoding: utf-8
class MarketingsController < ApplicationController
  before_filter :authorize, :correct_marketing, only: [:edit, :update]
  def edit
    @marketing = current_vitrine.marketing
 end

  def update
    @marketing = current_vitrine.marketing
    if @marketing.update_attributes(params[:marketing])
      redirect_to(action: :edit, id: @marketing, format: :html)
      flash[:success] = 'Política Atualizada'
    else
      render :edit
    end
  end

  def correct_marketing
    @marketing = Marketing.find(params[:id])
    redirect_to login_path unless current_vitrine?(@marketing.vitrine)
  end
end
