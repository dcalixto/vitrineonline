class AddBuyerNameToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :buyer_name, :string
  end
end
