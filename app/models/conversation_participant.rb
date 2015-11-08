# == Schema Information
#
# Table name: conversation_participants
#
#  id              :integer          not null, primary key
#  has_read        :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer          not null
#  conversation_id :integer          not null
#

class ConversationParticipant < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation
  attr_accessible :user_id, :has_read
end
