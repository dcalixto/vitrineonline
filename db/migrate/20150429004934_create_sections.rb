class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :vitrine_id, :null => false
      t.string :name
      t.timestamps
    end
      add_index :sections, :vitrine_id
  end
end
