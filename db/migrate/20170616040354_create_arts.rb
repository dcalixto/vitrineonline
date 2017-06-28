class CreateArts < ActiveRecord::Migration
  def change
    create_table :arts do |t|
      t.string :name
      t.integer :block_id
       t.string :slug
      t.timestamps
    end
  end
end
