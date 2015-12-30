class DropColorIdFromProducts < ActiveRecord::Migration
  def up
   remove_column :products, :color_id
  
  end

  def down
  end
end
