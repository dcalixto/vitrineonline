class AddColorIdToProductData < ActiveRecord::Migration
  def change
    add_column :product_data, :color_id, :integer
  end
end
