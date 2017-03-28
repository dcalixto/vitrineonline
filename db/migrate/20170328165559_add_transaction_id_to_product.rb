class AddTransactionIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :transaction_id, :integer
  end
end
