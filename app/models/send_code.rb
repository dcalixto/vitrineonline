#require 'twilio-ruby'
#class SendCode < ActiveRecord::Base

#def initialize
#     account_sid = "ACe5a172bd7ee1df24b1ae6b7806233d02"
#     auth_token = "841ed17ef38114ecc5d85bd8e5e37017"
#     @client = Twilio::REST::Client.new account_sid, auth_token
#     @t_phone = "+553139587515"
#   end

#   def send_sms(options = {})
#     @client.account.sms.messages.create(options.merge!({:from => @t_phone}))
#
#   end
#


#end
