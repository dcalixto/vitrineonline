class AddUserNeighborhoodToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :user_neighborhood, :string
  end
end
