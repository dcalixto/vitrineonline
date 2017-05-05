class AddTransactionIdToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :transaction_id, :string
  end
end
