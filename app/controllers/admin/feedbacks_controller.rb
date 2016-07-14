class Admin::FeedbacksController < Admin::ResourceController

  def index
  #  @users = User.all

    @search = Feedback.ransack(params[:q])
    @feedbacks = @search.result(distinct: true).per_page_kaminari(params[:page]).per(22)
  end

end
