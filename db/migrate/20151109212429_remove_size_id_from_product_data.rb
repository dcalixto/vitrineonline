class RemoveSizeIdFromProductData < ActiveRecord::Migration
  def up
    remove_column :product_data, :size_id
  end

  def down
    add_column :product_data, :size_id, :integer
  end
end
