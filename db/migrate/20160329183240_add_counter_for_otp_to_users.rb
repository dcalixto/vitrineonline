class AddCounterForOtpToUsers < ActiveRecord::Migration
  def change
    add_column :users, :otp_counter, :integer
  end
end
