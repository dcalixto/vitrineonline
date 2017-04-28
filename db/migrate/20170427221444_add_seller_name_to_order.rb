class AddSellerNameToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :seller_name, :string
  end
end
