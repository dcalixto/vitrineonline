class CreateBrandships < ActiveRecord::Migration
  def change
    create_table :brandships do |t|

      t.integer :product_id, :null => false
      t.integer :brand_id, :null => false
      t.integer  :product_data_id
      t.integer :order_id

      t.timestamps
    end
    add_index  :brandships, :product_id
    add_index  :brandships, :brand_id
    # add_index  :sizeships, :order_id
  end
end
