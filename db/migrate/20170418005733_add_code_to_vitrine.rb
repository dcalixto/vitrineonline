class AddCodeToVitrine < ActiveRecord::Migration
  def change
    add_column :vitrines, :code, :string
  end
end
