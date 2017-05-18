class AddDisputeIdToImage < ActiveRecord::Migration
  def change
    add_column :images, :dispute_id, :integer
  end
end
