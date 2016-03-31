class AddAddressSupplementToVitrine < ActiveRecord::Migration
  def change
    add_column :vitrines, :address_supplement, :text
  end
end
