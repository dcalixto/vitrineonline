class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :slug
      t.string :name
      t.integer :category_id
      t.timestamps
    end

    add_index :subcategories, :category_id
  end
end
