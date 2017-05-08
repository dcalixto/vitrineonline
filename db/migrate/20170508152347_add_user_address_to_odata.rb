class AddUserAddressToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :user_address, :string
  end
end
