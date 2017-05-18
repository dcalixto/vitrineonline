class AddProductImageToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :product_image, :string
  end
end
