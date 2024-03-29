class CreateVitrines < ActiveRecord::Migration
  def change
    create_table :vitrines do |t|

      t.string   :logo
      t.string   :slug
      t.string   :name
      t.string   :codigo
      t.text     :about
      t.integer  :user_id,          :null => false
      t.string   :address
      t.string   :neighborhood
      t.string   :postal_code
      t.string   :address_supplement
      t.float    :latitude
      t.float    :longitude
      t.integer   :impressions_count
      t.boolean  :branded,    :default => false
      t.string :code
      t.integer :city_id
      t.integer :state_id
      t.string :email

      t.timestamps
    end
    add_index :vitrines, :slug
    add_index :vitrines, :user_id, :unique => true
    add_index :vitrines,  :impressions_count
  end
end
