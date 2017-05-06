class RemoveBrandedFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :branded
  end

  def down
    add_column :products, :branded, :boolean
  end
end
