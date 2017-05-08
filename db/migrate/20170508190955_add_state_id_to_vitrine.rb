class AddStateIdToVitrine < ActiveRecord::Migration
  def change
    add_column :vitrines, :state_id, :integer
  end
end
