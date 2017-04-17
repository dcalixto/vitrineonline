class AddTotalFeedbacksToPdata < ActiveRecord::Migration
  def change
    add_column :pdata, :total_feedbacks, :integer, default: 0
  end
end
