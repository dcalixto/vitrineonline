class AddUserIdToPdata < ActiveRecord::Migration
  def change
    add_column :pdata, :user_id, :integer
  end
end
