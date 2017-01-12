class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer  :vitrine_id,                                                  :null => false
      t.string   :slug
      t.string   :name,                                                        :null => false
      t.decimal  :price,                                          :precision => 9, :scale => 2
      t.text     :detail
      t.integer  :gender_id,                                                   :null => false                                                  
      t.integer  :category_id,                                                 :null => false
      t.integer  :subcategory_id,                                              :null => false
      t.integer   :impressions_count
      t.integer   :color_id
      t.integer   :size_d 
      t.integer  :brand_id                                             
      t.integer  :material_id
      t.integer  :condition_id

      t.string   :meta_keywords
      t.integer  :quantity,                                                     :default => 0
      t.string   :status
      t.string   :current_step
      
      t.timestamps
    end
    add_index :products, :slug
    add_index :products, :vitrine_id
    add_index :products, :category_id
    add_index :products, :subcategory_id
     add_index :products, :gender_id
   add_index :products, :impressions_count

       add_index :products, :brand_id
    add_index :products, :material_id
    add_index :products, :condition_id

  
  end
end
