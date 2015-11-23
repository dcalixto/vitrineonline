class CreateVitrines < ActiveRecord::Migration
  def change
    create_table :vitrines do |t|

      t.string   :logo
      t.string   :b1
      t.string   :b2
      t.string   :b3
      t.string   :slogan
      t.string   :slug
      t.string   :url
      t.string   :code
      t.string   :name
      t.text     :about
      t.integer  :user_id,          :null => false
     
      
      
      t.timestamps
    end
    add_index :vitrines, :slug, :unique => true
    add_index :vitrines, :user_id, :unique => true

  end
end
