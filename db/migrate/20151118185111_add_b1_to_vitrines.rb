class AddB1ToVitrines < ActiveRecord::Migration
  def change
    add_column :vitrines, :b1, :string
  end
end
