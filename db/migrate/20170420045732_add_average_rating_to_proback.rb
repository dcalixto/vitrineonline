class AddAverageRatingToProback < ActiveRecord::Migration
  def change
    add_column :probacks, :average_rating, :float,  default: 0
  end
end
