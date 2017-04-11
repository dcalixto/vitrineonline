class AddDiameterToProduct < ActiveRecord::Migration
  def change
    add_column :products, :diamenter, :float
  end
end
