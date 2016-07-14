class Admin::VitrinesController < Admin::ResourceController

    def index
  #  @users = User.all

    @search = Vitrine.ransack(params[:q])
    @vitrines = @search.result(distinct: true).per_page_kaminari(params[:page]).per(22)
  end

end
