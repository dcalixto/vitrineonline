class CreateVitrines < ActiveRecord::Migration
  def change
    create_table :vitrines do |t|

      t.string   :logo
      t.string   :slogan
      t.string   :slug
      t.string   :url
      t.string   :code
      t.string   :name
      t.text     :about
      t.integer  :user_id,          :null => false
      t.string   :address
      t.string   :neighborhood
      t.string   :postal_code
      t.string   :address_supplement
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :vitrines
    add_index :vitrines, :user_id, :unique => true

  end
end
