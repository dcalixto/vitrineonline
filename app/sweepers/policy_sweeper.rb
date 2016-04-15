
class PolicySweeper < ActionController::Caching::Sweeper
  observe Policy

  def sweep(policy)

expire_fragment('policy_menu')
expire_fragment('busca')
expire_fragment('logo')

expire_fragment('policy_block')



  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end
