
class UserSweeper < ActionController::Caching::Sweeper
  observe User

  def sweep(user)

expire_fragment('user_menu')
expire_fragment('busca')
expire_fragment('logo')





  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end
