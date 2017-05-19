class AddBfToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :bf, :string
  end
end
