class AddBrandedToVitrine < ActiveRecord::Migration
  def change
    add_column :vitrines, :branded, :boolean, :default => false
  end
end
