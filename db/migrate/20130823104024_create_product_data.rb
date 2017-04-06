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
      t.integer  "obrand_id"
      t.string   "meta_keywords"
      t.datetime "created_at",                                                  :null => false
      t.datetime "updated_at",                                                  :null => false
      t.string   "status"
       t.string   "current_step"
      t.string   "name"
      t.decimal  "price",          :precision => 9, :scale => 2
      t.integer  "quantity",                                     :default => 0
      t.boolean :is_shared_on_facebook,  default: false
      t.boolean  :is_shared_on_twitter, default: false
      t.timestamps
    end
    add_index :product_data, :slug
    add_index :product_data, :vitrine_id
    add_index :product_data, :category_id
    add_index :product_data, :subcategory_id
    add_index :product_data, :gender_id
    add_index :product_data, :color_id
    add_index :product_data, :size_id
    add_index :product_data, :material_id
   add_index :product_data, :brand_id
   add_index :product_data, :obrand_id

    add_index :product_data, :condition_id
  end
end
