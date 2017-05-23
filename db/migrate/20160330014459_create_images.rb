class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
     t.string   :ifoto
      t.integer  :product_id,   :null => false
 t.integer   :pdata_id
      t.timestamps



    end
     add_index :images, :product_id
     add_index :images, :product_data_id

  end
end
