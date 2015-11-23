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
      t.integer :size_id
      t.integer :color_id
      t.integer :gender_id
      t.integer :category_id
      t.integer :subcategory_id
      t.integer :condition_id
      t.integer :material_id
      t.string :track_number

      t.timestamps
    end
    add_index :orders, :product_id, :unique => true
    add_index :orders, :cart_id, :unique => true
    add_index :orders, :seller_id, :unique => true
    add_index :orders, :buyer_id, :unique => true
    add_index :orders, :feedback_id, :unique => true
    add_index :orders, :size_id, :unique => true
    add_index :orders, :color_id, :unique => true
    add_index :orders, :gender_id, :unique => true
    add_index :orders, :category_id, :unique => true
    add_index :orders, :subcategory_id, :unique => true
    add_index :orders, :condition_id, :unique => true
    add_index :orders, :material_id, :unique => true
  end
end
