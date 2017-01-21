class CreateColorships < ActiveRecord::Migration
  def change
    create_table :colorships do |t|
      t.integer :product_id, :null => false
      t.integer  :product_data_id
      t.integer :color_id, :null => false
  
 t.timestamps
    end
    add_index  :colorships, :product_id
    add_index  :colorships, :color_id


  end
end
