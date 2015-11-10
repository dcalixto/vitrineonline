class AddSizeIdToProductData < ActiveRecord::Migration
  def change
    add_column :product_data, :size_id, :integer
  end
end
