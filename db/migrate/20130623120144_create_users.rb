class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string   :email,                                    :null => false
      t.string   :password_digest,                          :null => false
      t.string   :auth_token,                               :null => false
      t.string   :password_reset_token
      t.datetime :password_reset_at
      t.datetime :last_read_messages_at
      t.datetime :login_at
      t.string   :avatar
      t.string   :banner
      t.string   :slug
      t.string   :name,                                     :null => false
      t.string   :surname,                                  :null => false
      t.string   :gender,                                   :null => false
      t.boolean  :banned,                :default => false
      t.string   :address
      t.integer  :state_id
      t.integer  :city_id
      t.boolean  :admin,                 :default => false
      t.string   :neighborhood
      t.string   :postal_code
      t.string   :address_supplement
      t.string   :ip_address
      t.string   :provider
      t.string   :uid
      t.string   :oauth_token
      t.datetime  :oauth_expires_at
      t.boolean :email_confirmed,          :default => false
      t.string :confirm_token
      t.string :phone
      t.string :otp_secret_key
      t.integer :otp_counter
      t.float :latitude
      t.float :longitude
      


      t.timestamps
    end
    add_index :users, :email,                :unique => true
    add_index :users, :slug
    add_index :users, :auth_token,:unique => true
    add_index :users, :state_id
    add_index :users, :city_id
    add_index :users, :oauth_token, :unique => true
    add_index :users, :confirm_token, :unique => true
    add_index :users, :phone
   add_index :users, :otp_secret_key
    add_index :users, :otp_counter




  end
end
