class AddBrandedToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :branded, :boolean,  :default => false
  end
end
