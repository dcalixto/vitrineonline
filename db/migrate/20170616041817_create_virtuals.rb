class CreateVirtuals < ActiveRecord::Migration
  def change
    create_table :virtuals do |t|
      t.string :name
      t.integer :block_id
      t.timestamps
    end
  end
end
