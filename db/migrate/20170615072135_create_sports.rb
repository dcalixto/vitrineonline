class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :category
      t.integer :block_id
       t.string :slug
      t.timestamps
    end
  end
end
