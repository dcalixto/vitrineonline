class CreateSizeships < ActiveRecord::Migration
  def change
    create_table :sizeships do |t|
      t.integer :product_id, :null => false
      t.integer :size_id, :null => false

      t.timestamps
    end
    add_index  :sizeships, :product_id
    add_index  :sizeships, :size_id
  end
end
