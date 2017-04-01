class AddFeedbackCounterToProducts < ActiveRecord::Migration
  def change
    add_column :products, :feedback_counter, :integer, default: 0
  end
end
