class CreateProdbacks < ActiveRecord::Migration
  def change
    create_table :prodbacks do |t|


      t.text     :buyer_comment
      t.integer  :product_id
      t.integer  :order_id
      t.integer  :buyer_rating
      t.datetime :buyer_feedback_date
      t.integer  :cached_buyer_rating_total
      t.float    :cached_weighted_average


      t.timestamps
    end
    add_index :prodbacks, :product_id
  
  end
end
