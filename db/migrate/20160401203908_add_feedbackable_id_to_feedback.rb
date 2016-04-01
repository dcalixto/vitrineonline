class AddFeedbackableIdToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :feedbackable_id, :integer
  end
end
