
class MessageSweeper < ActionController::Caching::Sweeper
  observe Message

  def sweep(message)

expire_fragment('message_menu')
expire_fragment('busca')
expire_fragment('logo')





  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end
