# encoding: utf-8
class MessageObserver < ActiveRecord::Observer
  observe :message

  def after_create(message)
    conversation = message.conversation

    participants = conversation.participants(:not => message.user)
    participants.each do |u|
      broadcast("/user/#{u.id}", {
          message: {
              id: message.id,
          },
          conversation: {
              id: conversation.id,
          }
      })
    end
  end

  def broadcast(channel, data)
    PrivatePub.publish_message(PrivatePub.message(channel, data))
  end
end



