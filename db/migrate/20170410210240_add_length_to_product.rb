class AddLengthToProduct < ActiveRecord::Migration
  def change
    add_column :products, :length, :float
  end
end
