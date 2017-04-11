class AddHeightToProduct < ActiveRecord::Migration
  def change
    add_column :products, :height, :float
  end
end
