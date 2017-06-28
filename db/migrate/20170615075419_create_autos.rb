class CreateAutos < ActiveRecord::Migration
  def change
    create_table :autos do |t|
      t.string :item
      t.integer :block_id
       t.string :slug

      t.timestamps
    end
  end
end
