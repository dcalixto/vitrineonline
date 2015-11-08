namespace :cleanup do
  desc "removes stale and inactive products from the database"
  task :products => :environment do
    # Find all the products older than yesterday, that are not active yet
    stale_products = Product.where("DATE(created_at) < DATE(?)", Date.yesterday).where("status is not 'active'")

    # delete them
    stale_products.map(&:destroy)
  end
end
