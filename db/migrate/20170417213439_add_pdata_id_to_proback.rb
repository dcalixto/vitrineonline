class AddPdataIdToProback < ActiveRecord::Migration
  def change
    add_column :probacks, :pdata_id, :integer
  end
end
