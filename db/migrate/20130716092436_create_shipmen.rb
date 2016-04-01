class CreateShipmen < ActiveRecord::Migration
  def change
    create_table :shipmen do |t|
     t.integer :policy_id, :null => false
     t.integer :shipping_id, :null => false
     t.integer :product_id
      t.integer :vitrine_id
      t.timestamps
    end
      add_index  :shipmen, :policy_id
      add_index  :shipmen, :shipping_id
      add_index  :shipmen, :product_id
      add_index  :shipmen, :vitrine_id
  end
end
