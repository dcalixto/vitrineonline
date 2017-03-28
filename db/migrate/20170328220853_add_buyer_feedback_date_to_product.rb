class AddBuyerFeedbackDateToProduct < ActiveRecord::Migration
  def change
    add_column :products, :buyer_feedback_date, :datetime
  end
end
