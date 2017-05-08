class AddUserStateToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :user_state, :string
  end
end
