class AddProductPriceToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :product_price, :decimal
  end
end
