class AddConditionIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :condition_id, :integer
  end
end
