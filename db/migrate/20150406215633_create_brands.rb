class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end
    add_index :brands, :slug
  end
end
