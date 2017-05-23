class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer    :order_id,  :null => false
      t.decimal    :store_fee, precision: 9, scale: 2
      t.string     :transaction_id, :null => false
      t.string     :status
      t.integer    :user_id
      t.timestamps
    end
    add_index :transactions, :order_id
  end
end
