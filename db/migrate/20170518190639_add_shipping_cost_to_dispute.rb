class AddShippingCostToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :shipping_cost, :string
  end
end
