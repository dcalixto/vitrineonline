class AddAddressToVitrine < ActiveRecord::Migration
  def change
    add_column :vitrines, :address, :string
  end
end
