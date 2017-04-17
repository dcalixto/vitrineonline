class AddAverageRatingToPdata < ActiveRecord::Migration
  def change
    add_column :pdata, :average_rating, :float,  default: 0
  end
end
