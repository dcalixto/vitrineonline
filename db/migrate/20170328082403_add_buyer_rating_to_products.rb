class AddBuyerRatingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :buyer_rating, :integer
  end
end
