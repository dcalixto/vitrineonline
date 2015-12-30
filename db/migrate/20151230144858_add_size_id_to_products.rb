class AddSizeIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :size_id, :integer
  end
end
