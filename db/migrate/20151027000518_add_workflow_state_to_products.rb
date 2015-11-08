class AddWorkflowStateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :workflow_state, :string
  end
end
