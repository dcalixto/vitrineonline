class OffersController < ApplicationController

  def create
    @offer = current_vitrine.offers.build(params[:offer])
    if @offer.save
      redirect_to new_offer_path
      flash[:success] = 'Promoção adicionado'
    else
      render :new
    end
  end
  def index
  end

  def new
    @offer = Offer.new
  end
end
