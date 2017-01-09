class CreateImpressions < ActiveRecord::Migration
  def change
    create_table :impressions do |t|
      t.string :ip_address
      t.integer :product_id
      t.integer :vitrine_id
      t.timestamps
   t.string   :impressionable_type,  polymorphic: true
   t.integer  :impressionable_id, polymorphic: true    
    
    end
   
  add_index :impressions, [:impressionable_id, :impressionable_type]
  
  end
end
