class CreateFeedbackships < ActiveRecord::Migration
  def change
    create_table :feedbackships do |t|
      t.integer :product_id
      t.integer :feedback_id
      t.integer :order_id

      t.timestamps
    end
     add_index :feedbackships, :product_id
     add_index :feedbackships, :order_id
add_index :feedbackships, :feedback_id

  end
end
