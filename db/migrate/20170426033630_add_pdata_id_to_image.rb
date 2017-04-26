class AddPdataIdToImage < ActiveRecord::Migration
  def change
    add_column :images, :pdata_id, :integer
  end
end
