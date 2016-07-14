class Admin::ProductsController < Admin::ResourceController

  def index
  #  @users = User.all

    @search = Product.ransack(params[:q])
    @products = @search.result(distinct: true).per_page_kaminari(params[:page]).per(22)
  end

end
