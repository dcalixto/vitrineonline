class AddPostalCodeToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :vitrine_postal_code, :string
  end
end
