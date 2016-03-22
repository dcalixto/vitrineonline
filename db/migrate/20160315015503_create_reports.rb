class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :reportable_id, polymorphic: true
      t.string :reportable_type, polymorphic: true
      t.integer :user_id
      t.integer :product_id
      t.integer :vitrine_id
      t.text :content
      t.string :category
      t.timestamps
    end
    add_index :reports, [:reportable_id,:reportable_type]
  end
end
