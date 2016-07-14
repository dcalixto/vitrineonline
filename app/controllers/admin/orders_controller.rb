class Admin::OrdersController < Admin::ResourceController

 def index
  #  @users = User.all

    @search = Order.ransack(params[:q])
    @orders = @search.result(distinct: true).per_page_kaminari(params[:page]).per(22)
  end

end
