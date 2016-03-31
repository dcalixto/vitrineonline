class AddPostalCodeToVitrine < ActiveRecord::Migration
  def change
    add_column :vitrines, :postal_code, :string
  end
end
