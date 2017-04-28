class AddVitrineNameToPdata < ActiveRecord::Migration
  def change
    add_column :pdata, :vitrine_name, :string
  end
end
