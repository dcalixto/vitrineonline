class AddItemReceivedToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :item_received, :boolean, :defaul => true
  end
end
