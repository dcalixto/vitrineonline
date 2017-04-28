class AddUserNameToPdata < ActiveRecord::Migration
  def change
    add_column :pdata, :user_name, :string
  end
end
