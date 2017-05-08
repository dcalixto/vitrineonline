class AddUserPostalCodeToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :user_postal_code, :string
  end
end
