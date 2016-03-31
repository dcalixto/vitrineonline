class AddLongitudeToVitrine < ActiveRecord::Migration
  def change
    add_column :vitrines, :longitude, :float
  end
end
