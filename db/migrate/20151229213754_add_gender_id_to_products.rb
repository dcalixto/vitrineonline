class AddGenderIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :gender_id, :integer
  end
end
