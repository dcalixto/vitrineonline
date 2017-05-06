class AddDiametersToPdata < ActiveRecord::Migration
  def change
    add_column :pdata, :weight, :float
    add_column :pdata, :lenght, :float
    add_column :pdata, :width, :float
    add_column :pdata, :height, :float
    add_column :pdata, :diamenter, :float
    add_column :pdata, :code, :string
  end


end
