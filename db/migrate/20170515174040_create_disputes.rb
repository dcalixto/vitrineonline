class CreateDisputes < ActiveRecord::Migration
  def change
    create_table :disputes do |t|
      t.integer :order_id
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :seller_name
      t.integer :buyer_name
      t.string :status
      t.string :transaction_id
      t.decimal :amount, precision: 9, scale: 2
      t.string :motive
      t.string :solution
      t.text :buyer_comment
      t.text :seller_comment
      t.string :buyer_file
      t.string :seller_file
      t.timestamps
    end
  end
end
