class AddDisputeStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :dispute_status, :string
  end
end
