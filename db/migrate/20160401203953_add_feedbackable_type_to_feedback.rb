class AddFeedbackableTypeToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :feedbackable_type, :string
  end
end
