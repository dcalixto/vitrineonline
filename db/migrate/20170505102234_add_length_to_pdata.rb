class AddLengthToPdata < ActiveRecord::Migration
  def change
    add_column :pdata, :length, :float
  end
end
