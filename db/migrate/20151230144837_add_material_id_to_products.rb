class AddMaterialIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :material_id, :integer
  end
end
