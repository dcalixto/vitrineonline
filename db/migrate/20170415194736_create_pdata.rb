class CreatePdata < ActiveRecord::Migration
  def change
    create_table :pdata do |t|
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
      t.float   :average_rating,  default: 0
      t.integer :total_feedbacks,  default: 0
      t.integer :user_id
      t.string  :user_name
      t.string  :vitrine_name
      t.integer :impressions_count
      t.string :code
      t.float  :weight
      t.float  :length
      t.float  :width
      t.float  :height
      t.float  :diameter
       t.boolean :freeship, :default => false
      t.timestamps
    end

    add_index :pdata, :slug
    add_index :pdata, :vitrine_id
    add_index :pdata, :category_id
    add_index :pdata, :subcategory_id
    add_index :pdata, :gender_id
    add_index :pdata, :color_id
    add_index :pdata, :size_id
    add_index :pdata, :material_id
    add_index :pdata, :brand_id

    add_index :pdata, :condition_id




  end
end





