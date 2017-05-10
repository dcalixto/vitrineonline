class AddNeighborhoodToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :vitrine_neighborhood, :string
  end
end
