class AddUserCityToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :user_city, :string
  end
end
