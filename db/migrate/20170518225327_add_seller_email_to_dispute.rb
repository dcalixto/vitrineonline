class AddSellerEmailToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :seller_email, :string
  end
end
