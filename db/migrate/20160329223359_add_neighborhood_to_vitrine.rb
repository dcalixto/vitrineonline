class AddNeighborhoodToVitrine < ActiveRecord::Migration
  def change
    add_column :vitrines, :neighborhood, :string
  end
end
