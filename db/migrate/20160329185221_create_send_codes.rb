class CreateSendCodes < ActiveRecord::Migration
  def change
    create_table :send_codes do |t|
      t.string :account_sid
      t.string :auth_token
      t.string :client
      t.string :t_phone

      t.timestamps
    end
    add_index :send_codes, :account_sid
 add_index :send_codes, :auth_token
add_index :send_codes, :client
add_index :send_codes, :t_phone



  end
end
