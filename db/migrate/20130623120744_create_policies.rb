class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.integer :policieable_id, polymorphic: true
      t.string :policieable_type, polymorphic: true
      t.string   :paypal
      t.integer   :vitrine_id, :null => false
      t.integer   :product_id
      t.text     :guarantee
      t.string :parcelamento
      t.string :return
      t.timestamps
    end
    add_index :policies, :vitrine_id
   add_index :policies, [:policieable_id, :policieable_type] 
  end
end
