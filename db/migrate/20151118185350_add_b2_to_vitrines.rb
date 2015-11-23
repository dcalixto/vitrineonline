class AddB2ToVitrines < ActiveRecord::Migration
  def change
    add_column :vitrines, :b2, :string
  end
end
