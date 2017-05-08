class AddTcreatedAtToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :tcreated_at, :datetime
  end
end
