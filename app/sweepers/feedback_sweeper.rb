
class FeedbackSweeper < ActionController::Caching::Sweeper
  observe Feedback

  def sweep(feedback)

expire_fragment('feedback_menu')
expire_fragment('busca')
expire_fragment('logo')





  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end
