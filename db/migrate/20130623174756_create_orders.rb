class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
  
           
      t.integer :cart_id
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :product_id
      t.integer :quantity, default: 0
      t.decimal :shipping_cost, precision: 9, scale: 2
      t.string :shipping_method
      t.string :transaction_status
      t.string :status
      t.integer :feedback_id
      t.string :track_number

      t.timestamps
    end
    add_index :orders, :product_id
    add_index :orders, :cart_id
    add_index :orders, :seller_id
    add_index :orders, :buyer_id
    add_index :orders, :feedback_id
 

   
  end
end
