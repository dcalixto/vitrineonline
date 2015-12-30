class DropConditionIdFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :condition_id
  end

  def down
  end
end
