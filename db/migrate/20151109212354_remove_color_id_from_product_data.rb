class RemoveColorIdFromProductData < ActiveRecord::Migration
  def up
    remove_column :product_data, :color_id
  end

  def down
    add_column :product_data, :color_id, :integer
  end
end
