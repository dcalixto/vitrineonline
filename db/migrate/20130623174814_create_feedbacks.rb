class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|

      t.integer :feedbackable_id, polymorphic: true
      t.string :feedbackable_type, polymorphic: true
      

      t.text     :seller_comment
      t.text     :buyer_comment
      t.integer  :user_id
      t.integer  :vitrine_id
      t.integer  :product_id
      t.integer  :buyer_rating
      t.integer  :seller_rating
      t.datetime :buyer_feedback_date
      t.datetime :seller_feedback_date
      t.integer  :cached_buyer_rating_total
      t.integer  :cached_seller_rating_total
      t.float    :cached_weighted_average

      t.timestamps
    end
    add_index :feedbacks, :user_id
    add_index :feedbacks, :vitrine_id
    add_index :feedbacks, :product_id
    add_index :feedbacks, [:feedbackable_id, :feedbackable_type]

  end
end
