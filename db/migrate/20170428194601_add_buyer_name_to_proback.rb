class AddBuyerNameToProback < ActiveRecord::Migration
  def change
    add_column :probacks, :buyer_name, :string
  end
end
