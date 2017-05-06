class RemoveObrandIdFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :obrand_id
  end

  def down
    add_column :products, :obrand_id, :integer
  end
end
