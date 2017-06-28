class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :name
      t.integer :block_id
       t.string :slug
      t.timestamps
    end
  end
end
