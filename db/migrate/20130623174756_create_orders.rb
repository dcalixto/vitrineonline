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
      t.integer  :brand_id                                             
      t.integer  :obrand_id     
      t.integer  :material_id
      t.integer  :condition_id
      t.integer  :color_id
      t.integer  :size_id
      t.string :buyer_name
      t.string :code
      t.integer :pdata_id
      t.string :seller_name
      t.boolean :dispute_closed, :default => false
    
    t.timestamps
  end
  add_index :orders, :product_id
  add_index :orders, :cart_id
  add_index :orders, :seller_id
  add_index :orders, :buyer_id
  add_index :orders, :feedback_id

  add_index :orders, :brand_id
  add_index :orders, :obrand_id

  add_index :orders, :color_id
  add_index :orders, :size_id


  add_index :orders, :material_id
  add_index :orders, :condition_id



end
end
