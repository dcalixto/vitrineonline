class AddBrandIdToProductData < ActiveRecord::Migration
  def change
    add_column :product_data, :brand_id, :integer
  end
end
