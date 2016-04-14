
class VitrineSweeper < ActionController::Caching::Sweeper
  observe Vitrine

  def sweep(vitrine)

expire_fragment('vitrine_menu')
expire_fragment('busca')
expire_fragment('logo')





  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end
