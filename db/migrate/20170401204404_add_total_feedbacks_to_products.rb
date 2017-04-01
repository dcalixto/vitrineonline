class AddTotalFeedbacksToProducts < ActiveRecord::Migration
  def change
    add_column :products, :total_feedbacks, :integer,  default: 0
  end
end
