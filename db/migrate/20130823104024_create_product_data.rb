class CreateProductData < ActiveRecord::Migration
  def change
    create_table :product_data do |t|
     t.string   "slug"
      t.integer  "vitrine_id",                                                  :null => false
      t.text     "detail"
      t.integer  "category_id"
      t.integer  "gender_id"
      t.integer  "subcategory_id"
      t.integer  "color_id"
      t.integer  "size_id"
      t.integer  "material_id"
      t.integer  "condition_id"
      t.integer  "brand_id"
      t.datetime "created_at",                                                  :null => false
      t.datetime "updated_at",                                                  :null => false
      t.string   "status"
      t.string   "name"
      t.decimal  "price",          :precision => 9, :scale => 2
      t.integer  "quantity",                                     :default => 0
      t.timestamps
    end

    add_index :product_data, :vitrine_id
    add_index :product_data, :category_id
    add_index :product_data, :subcategory_id
    add_index :product_data, :gender_id
    add_index :product_data, :color_id
    add_index :product_data, :size_id
    add_index :product_data, :material_id
    add_index :product_data, :condition_id
  end
end
