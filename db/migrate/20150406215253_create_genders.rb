class CreateGenders < ActiveRecord::Migration
  def change
    create_table :genders do |t|
      t.string :slug
      t.string :gender
      t.timestamps
    end
    add_index :genders, :slug
  end
end
