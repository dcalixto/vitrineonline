class CreateVitrines < ActiveRecord::Migration
  def change
    create_table :vitrines do |t|

      t.string   :logo
      t.string   :banner
      t.string   :slogan
      t.string   :slug
      t.string   :url
      t.string   :code
      t.string   :name
      t.text     :about
      t.integer  :user_id,          :null => false
      t.timestamps
    end
    add_index :vitrines, :slug
    add_index :vitrines, :user_id
  end
end
