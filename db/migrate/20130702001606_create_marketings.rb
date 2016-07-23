class CreateMarketings < ActiveRecord::Migration
  def change
    create_table :marketings do |t|
      t.string :ad
      t.integer :vitrine_id, :null => false
      t.string :slogan
      t.string :url
        t.string :banner
        t.string :facebook
        t.string :twitter
   
      t.timestamps
    end
     add_index :marketings, :vitrine_id
  end
end
