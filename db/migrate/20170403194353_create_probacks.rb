class CreateProbacks < ActiveRecord::Migration
  def change
    create_table :probacks do |t|
      t.text     :buyer_comment
      t.integer  :user_id
      t.integer  :feedback_id
      t.integer  :product_id
      t.integer  :buyer_rating
      t.datetime :buyer_feedback_date
      t.integer :pdata_id
    t.string :buyer_name
       t.float  :average_rating, default: 0
  t.integer :total_feedbacks, default: 0
      t.timestamps
    end
       add_index :probacks, :user_id
    add_index :probacks, :product_id
      add_index :probacks, :feedback_id

  end
end
