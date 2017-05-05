class AddPdataIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :pdata_id, :integer
  end
end
