class RemoveBrandIdFromProductData < ActiveRecord::Migration
  def up
    remove_column :product_data, :brand_id
  end

  def down
    add_column :product_data, :brand_id, :integer
  end
end
