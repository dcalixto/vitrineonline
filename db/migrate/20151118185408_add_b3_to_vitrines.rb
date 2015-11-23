class AddB3ToVitrines < ActiveRecord::Migration
  def change
    add_column :vitrines, :b3, :string
  end
end
