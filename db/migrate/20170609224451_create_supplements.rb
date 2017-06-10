class CreateSupplements < ActiveRecord::Migration
  def change
    create_table :supplements do |t|
t.string :kind
      t.timestamps
    end
  end
end
