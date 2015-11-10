class RemoveMaterialIdFromProductData < ActiveRecord::Migration
  def up
    remove_column :product_data, :material_id
  end

  def down
    add_column :product_data, :material_id, :integer
  end
end
