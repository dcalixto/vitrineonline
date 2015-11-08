class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.string   :paypal
      t.integer   :vitrine_id, :null => false
      t.text     :guarantee
      t.timestamps
    end
    add_index :policies, :vitrine_id
  end
end
