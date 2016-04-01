class AddOrderableIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :orderable_id, :integer
  end
end
