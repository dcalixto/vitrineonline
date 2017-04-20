class AddTotalFeedbacksToProback < ActiveRecord::Migration
  def change
    add_column :probacks, :total_feedbacks, :integer,  default: 0
  end
end
