class AddSellerNameToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :seller_name, :string
  end
end
