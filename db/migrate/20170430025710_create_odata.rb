class CreateOdata < ActiveRecord::Migration
  def change
    create_table :odata do |t|

      t.integer :cart_id
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :product_id
      t.integer :pdata_id
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
      t.string :seller_name
      t.string :buyer_name
      t.integer :order_id
      t.string :transaction_id
      t.string :user_address
      t.string :user_neighborhood
      t.string :user_city
      t.string :user_state
      t.string :user_postal_code
      t.string :vitrine_postal_code
      t.string :vitrine_address
      t.string :vitrine_neighborhood
      t.string :vitrine_city
      t.string :vitrine_state
      t.datetime :tcreated_at
      t.datetime :tupdated_at

      t.timestamps
    end
    add_index :odata, :product_id
    add_index :odata, :cart_id
    add_index :odata, :seller_id
    add_index :odata, :buyer_id
    add_index :odata, :feedback_id

    add_index :odata, :brand_id
    add_index :odata, :obrand_id

    add_index :odata, :color_id
    add_index :odata, :size_id


    add_index :odata, :material_id
    add_index :odata, :condition_id


  end
end
