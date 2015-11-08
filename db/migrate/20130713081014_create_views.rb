class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :vitrine_id, :null => false
      t.string :ip_address
      t.timestamps
    end
    add_index :views, :vitrine_id
  end
end
