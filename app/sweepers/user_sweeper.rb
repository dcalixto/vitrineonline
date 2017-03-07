
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
expire_fragment('address')
expire_fragment('user_block')
expire_fragment('user_info_box')
expire_fragment('products_home')
expire_fragment('front_banner')
  end

  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end
