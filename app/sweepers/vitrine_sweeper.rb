
class VitrineSweeper < ActionController::Caching::Sweeper
  observe Vitrine

  def sweep(vitrine)

expire_fragment('vitrine_menu')
expire_fragment('busca')
expire_fragment('logo')
expire_fragment('cs')
expire_fragment('footer')
expire_fragment('js')
expire_fragment('fayeserver')
expire_fragment('facebook')
expire_fragment('drop')
expire_fragment('vitrine_address')
expire_fragment('vitrine_block')

expire_fragment('vitrine_info_box')
  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end
