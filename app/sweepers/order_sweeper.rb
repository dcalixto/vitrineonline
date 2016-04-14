
class OrderSweeper < ActionController::Caching::Sweeper
  observe Order

  def sweep(order)

expire_fragment('order_menu')
expire_fragment('busca')
expire_fragment('logo')





  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end
