class AddSfToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :sf, :string
  end
end
