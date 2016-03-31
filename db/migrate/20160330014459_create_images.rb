class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
     t.string   :img
      t.integer  :product_id,                                                  :null => false
      t.timestamps



    end
     add_index :images, :product_id
  end
end
