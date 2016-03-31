class AddLatitudeToVitrine < ActiveRecord::Migration
  def change
    add_column :vitrines, :latitude, :float
  end
end
