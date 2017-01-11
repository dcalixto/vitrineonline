class CreateConditionships < ActiveRecord::Migration
  def change
    create_table :conditionships do |t|
      t.integer :product_id, :null => false
      t.integer :condition_id, :null => false
      t.integer  :product_data_id
      t.integer :order_id
      t.timestamps
    end
    add_index  :conditionships, :product_id
    add_index  :conditionships, :condition_id
    # add_index  :sizeships, :order_id
  end
end
