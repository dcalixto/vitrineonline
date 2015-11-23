class CreateImpressions < ActiveRecord::Migration
  def change
    create_table :impressions do |t|
      t.string :ip_address
      t.integer :product_id, :null => false
      t.timestamps
    end
     add_index :impressions, :product_id, :unique => true
  end
end
