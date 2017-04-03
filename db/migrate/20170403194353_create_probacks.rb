class CreateProbacks < ActiveRecord::Migration
  def change
    create_table :probacks do |t|
      t.text     :buyer_comment
      t.integer  :user_id
      t.integer  :feedback_id
      t.integer  :product_id
      t.integer  :buyer_rating
      t.datetime :buyer_feedback_date

      t.timestamps
    end
       add_index :probacks, :user_id
    add_index :probacks, :product_id
      add_index :probacks, :feedback_id

  end
end
