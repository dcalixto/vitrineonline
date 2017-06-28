class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
 t.string :name
      t.integer :block_id
       t.string :slug
      t.timestamps
    end
  end
end
