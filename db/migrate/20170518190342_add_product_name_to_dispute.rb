class AddProductNameToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :product_name, :string
  end
end
