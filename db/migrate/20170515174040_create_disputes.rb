class CreateDisputes < ActiveRecord::Migration
  def change
    create_table :disputes do |t|
      t.integer :order_id
      t.integer :seller_id
      t.integer :buyer_id
      t.string :seller_name
      t.string :buyer_name
      t.string :status
      t.string :transaction_id
      t.decimal :amount, precision: 9, scale: 2
      t.string :motive
      t.string :solution
      t.text :buyer_comment
      t.text :seller_comment
      t.string :buyer_file
      t.string :seller_file
      t.boolean  :item_received,    :default => false
t.string :product_name
t.decimal :product_price
t.string :product_image
t.string :shipping_cost
t.string  :buyer_email
t.string :seller_email
      t.timestamps
    end
  end
end
