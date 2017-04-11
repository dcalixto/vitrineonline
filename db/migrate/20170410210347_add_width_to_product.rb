class AddWidthToProduct < ActiveRecord::Migration
  def change
    add_column :products, :width, :float
  end
end
