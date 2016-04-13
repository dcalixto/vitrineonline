# == Schema Information
#
# Table name: messages
#
#  id                          :integer          not null, primary key
#  body                        :text
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  conversation_id             :integer          not null
#  conversation_participant_id :integer          not null
#

class Message < ActiveRecord::Base
  belongs_to :conversation, touch: true
  belongs_to :conversation_participant
  has_one :user,
          through: :conversation_participant

  attr_accessible :body, :conversation_participant

  validates_presence_of :body, :conversation_participant, nil: false
  validates_associated :conversation_participant

include ActiveModel::Validations

  def author
    user.name
    user.avatar
  end
end
