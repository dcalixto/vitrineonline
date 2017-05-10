class AddVitrineAddressToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :vitrine_address, :string
  end
end
