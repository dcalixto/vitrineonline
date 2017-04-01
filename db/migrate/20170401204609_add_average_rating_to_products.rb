class AddAverageRatingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :average_rating, :integer,  default: 0
  end
end
