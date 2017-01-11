class CreateMaterialships < ActiveRecord::Migration
  def change
    create_table :materialships do |t|
      t.integer :product_id, :null => false
      t.integer :material_id, :null => false
      t.integer  :product_data_id
      t.integer :order_id
      t.timestamps
    end
    add_index  :materialships, :product_id
    add_index  :materialships, :material_id
    # add_index  :sizeships, :order_id
  end
end
