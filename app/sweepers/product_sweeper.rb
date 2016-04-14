
class ProductSweeper < ActionController::Caching::Sweeper
  observe Product

  def sweep(product)

expire_fragment('product_show')
expire_fragment('product')
expire_fragment('filtro_product')
expire_fragment('busca')
expire_fragment('logo')
expire_fragment('cs')
expire_fragment('footer')
expire_fragment('js')
expire_fragment('fayeserver')
expire_fragment('facebook')
expire_fragment('drop')




  #  FileUtils.rm_rf "#{page_cache_directory}/products/page"
  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end
