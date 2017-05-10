class AddPostalCodeToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :postal_code, :string
  end
end
