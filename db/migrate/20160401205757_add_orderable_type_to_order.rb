class AddOrderableTypeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :orderable_type, :string
  end
end
