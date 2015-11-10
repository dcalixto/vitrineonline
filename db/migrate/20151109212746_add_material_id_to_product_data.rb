class AddMaterialIdToProductData < ActiveRecord::Migration
  def change
    add_column :product_data, :material_id, :integer
  end
end
