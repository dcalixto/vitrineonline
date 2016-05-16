class BannersController < ApplicationController
  before_filter :authorize_user, only: [:update]

  def edit
 @user = User.cached_find(params[:id])
      if @user.save
      # redirect_to new_vitrine_banner_path
      redirect_to(action: :edit, only_path: true, format: :html)
      flash[:success] = 'Banner Adicionado'
    else
      render :edit, format: :html
    end
  end

end
