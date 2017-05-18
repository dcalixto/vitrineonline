class AddBuyerEmailToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :buyer_email, :string
  end
end
