class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer  :vitrine_id,                                                  :null => false
      t.string   :f1
      t.string   :f2
      t.string   :f3
      t.string   :f4
      t.string   :slug
      t.string   :name,                                                        :null => false
      t.decimal  :price,                                          :precision => 9, :scale => 2
      t.text     :detail
      t.integer  :gender_id,                                                   :null => false
      t.integer  :category_id,                                                 :null => false
      t.integer  :subcategory_id,                                              :null => false
      t.integer  :material_id
      t.integer  :condition_id
      t.integer  :size_id
      t.integer  :color_id
      t.integer  :brand_id
      t.string   :meta_keywords
      t.integer  :quantity,                                                     :default => 0
      t.string   :status
      t.timestamps
    end
    add_index :products, :slug
    add_index :products, :vitrine_id                                       
    add_index :products, :category_id
    add_index :products, :subcategory_id
    add_index :products, :material_id
    add_index :products, :condition_id
    add_index :products, :size_id
    add_index :products, :color_id
    add_index :products, :brand_id
    add_index :products, :gender_id
  end
end
