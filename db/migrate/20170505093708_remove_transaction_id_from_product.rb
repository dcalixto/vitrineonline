class RemoveTransactionIdFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :transaction_id
  end

  def down
    add_column :products, :transaction_id, :integer
  end
end
