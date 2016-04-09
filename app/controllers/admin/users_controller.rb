class Admin::UsersController < Admin::ResourceController

  # See admin/resource_controller.rb for more info..

  def index
  #  @users = User.all

    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true).per_page_kaminari(params[:page]).per(22)


  end

  def destroy
    if @user.destroy
      cookies.delete(:auth_token)
      redirect_to root_path
      flash[:success] = 'Conta deletada'
    else
      render :edit
    end
  end

end
