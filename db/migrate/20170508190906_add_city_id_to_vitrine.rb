class AddCityIdToVitrine < ActiveRecord::Migration
  def change
    add_column :vitrines, :city_id, :integer
  end
end
