class RemoveBuyerFeedbackDateFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :buyer_feedback_date
  end

  def down
    add_column :products, :buyer_feedback_date, :datetime
  end
end
