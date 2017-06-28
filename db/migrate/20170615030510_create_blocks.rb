class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :category
       t.string :slug
      t.timestamps
    end
  end
end
