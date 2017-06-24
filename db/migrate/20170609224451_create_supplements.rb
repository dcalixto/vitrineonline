class CreateSupplements < ActiveRecord::Migration
  def change
    create_table :supplements do |t|
     t.string :name
      t.timestamps
    end
  end
end
