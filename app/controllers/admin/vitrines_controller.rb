class Admin::VitrinesController < Admin::ResourceController

  # See admin/resource_controller.rb for more info..
  def index
  #  @users = User.all

    @search = Vitrine.ransack(params[:q])
    @vitrines = @search.result(distinct: true)#.page(per_page: 22, page: params[:page]).order('created_at DESC')
  end

end
