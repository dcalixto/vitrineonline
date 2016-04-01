class AddProductIdToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :product_id, :integer
  end
end
