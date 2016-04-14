
class UserSweeper < ActionController::Caching::Sweeper
  observe User

  def sweep(user)

expire_fragment('user_menu')
expire_fragment('busca')
expire_fragment('logo')
expire_fragment('cs')
expire_fragment('footer')
expire_fragment('js')
expire_fragment('fayeserver')
expire_fragment('facebook')
expire_fragment('drop')
  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end
