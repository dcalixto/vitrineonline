class AddTupdatedAtToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :tupdated_at, :datetime
  end
end
