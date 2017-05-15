class AddItemReceivedToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :item_received, :boolean
  end
end
