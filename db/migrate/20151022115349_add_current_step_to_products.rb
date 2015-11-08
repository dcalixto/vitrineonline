class AddCurrentStepToProducts < ActiveRecord::Migration
  def change
    add_column :products, :current_step, :string
    add_index  :products, :current_step
  end

end
