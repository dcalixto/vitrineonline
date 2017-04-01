class AddRateFromBuyersToProducts < ActiveRecord::Migration
  def change
    add_column :products, :rate_from_buyers, :integer, default: 0
  end
end
