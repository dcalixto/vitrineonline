class DropMaterialIdFromProducts < ActiveRecord::Migration
  def up
     remove_column :products, :material_id
  end

  def down
  end
end
