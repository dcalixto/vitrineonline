class AddCityToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :vitrine_city, :string
  end
end
