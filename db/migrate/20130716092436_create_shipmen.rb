class CreateShipmen < ActiveRecord::Migration
  def change
    create_table :shipmen do |t|
     t.integer :policy_id, :null => false
     t.integer :shipping_id, :null => false

      t.timestamps
    end
      add_index  :shipmen, :policy_id
      add_index  :shipmen, :shipping_id
  end
end
