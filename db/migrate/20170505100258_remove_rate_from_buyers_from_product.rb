class RemoveRateFromBuyersFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :rate_from_buyers
  end

  def down
    add_column :products, :rate_from_buyers, :integer
  end
end
