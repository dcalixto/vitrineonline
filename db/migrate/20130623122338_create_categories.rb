class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :slug
      t.string :name
      t.integer :gender_id, :null => false
      t.timestamps
    end
    add_index :categories, :slug
   add_index :categories, :gender_id
  end
end
