class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :block_id
       t.string :slug
      t.timestamps
    end
  end
end
