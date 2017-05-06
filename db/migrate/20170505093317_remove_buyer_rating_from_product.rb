class RemoveBuyerRatingFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :buyer_rating
  end

  def down
    add_column :products, :buyer_rating, :integer
  end
end
