class CreateMarketings < ActiveRecord::Migration
  def change
    create_table :marketings do |t|
      t.string :ad
      t.integer :vitrine_id, :null => false
    
      t.string :url
        t.string :banner
        t.string :facebook
        t.string :twitter
        t.string :instagram 
        t.string :pinterest
        t.string :youtube
      t.timestamps
    end
     add_index :marketings, :vitrine_id
  end
end
