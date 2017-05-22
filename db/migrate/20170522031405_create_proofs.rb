class CreateProofs < ActiveRecord::Migration
  def change
    create_table :proofs do |t|
     t.string :file
     t.integer :dispute_id
      t.timestamps
    end
  end
end
