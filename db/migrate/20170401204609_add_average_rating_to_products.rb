class AddAverageRatingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :average_rating, :float,  default: 0
  end
end
