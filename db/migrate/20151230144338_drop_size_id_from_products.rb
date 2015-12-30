class DropSizeIdFromProducts < ActiveRecord::Migration
  def up
   remove_column :products, :size_id
  end

  def down
  end
end
