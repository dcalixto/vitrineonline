class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text     :seller_comment
      t.text     :buyer_comment
      t.integer  :user_id
      t.integer  :vitrine_id
      t.integer  :buyer_rating
      t.integer  :seller_rating
      t.datetime :buyer_feedback_date
      t.datetime :seller_feedback_date

      t.timestamps
    end
    add_index :feedbacks, :user_id, :unique => true
    add_index :feedbacks, :vitrine_id, :unique => true

  end
end
