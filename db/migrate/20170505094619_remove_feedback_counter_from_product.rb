class RemoveFeedbackCounterFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :feedback_counter
  end

  def down
    add_column :products, :feedback_counter, :integer
  end
end
