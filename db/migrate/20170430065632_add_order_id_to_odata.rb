class AddOrderIdToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :order_id, :integer
  end
end
