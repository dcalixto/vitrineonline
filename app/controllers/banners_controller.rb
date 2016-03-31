class BannersController < ApplicationController


  before_filter :authorize_vitrine, only: [:create]

  def create
    @banner = current_vitrine.banners.build(params[:banner])
    if @banner.save
      #redirect_to new_vitrine_banner_path
        redirect_to(action: :new,  only_path: true, format: :html)
      flash[:success] = 'Banners adicionado'
    else
      render :new, format: :html
    end
  end

  def new
    @banner= Banner.new
  end

end
