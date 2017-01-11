class CreateColorships < ActiveRecord::Migration
  def change
    create_table :colorships do |t|
      t.integer :product_id, :null => false
      t.integer  :product_data_id
      t.integer :color_id, :null => false
      t.integer :order_id
 t.timestamps
    end
    add_index  :colorships, :product_id
    add_index  :colorships, :color_id
 #   add_index  :colorships, :order_id

  end
end
