class AddImageToPdata < ActiveRecord::Migration
  def change
    add_column :pdata, :image, :string
  end
end
