# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Conversation < ActiveRecord::Base
  has_many :conversation_participants, :dependent => :destroy
  has_many :users,
    :through => :conversation_participants
  has_many :messages, :dependent => :destroy
  has_one :display_message,
    :class_name => 'Message',
    :order => 'created_at DESC'

  def participants(options={})
    if options[:not].is_a? User
      users - [options[:not]]
    else
      users
    end
  end





end



