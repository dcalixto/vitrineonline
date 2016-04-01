class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|

      t.integer :offertable_id, polymorphic: true
      t.string :offertable_type, polymorphic: true
      t.integer :product_id
      t.integer :vitrine_id
      t.text :offer
      t.text :start_time
      t.text :end_time
      t.timestamps
    end

    add_index :offers, [:offertable_id, :offertable_type, :offer]

  end
end
