# encoding: utf-8
class MessagesController < ApplicationController
  #before_filter :authorize
  #cache_sweeper :message_sweeper

  def create
    # TODO: Handle 404
    @conversation = current_user.conversations.find(params[:conversation_id])
    @message = @conversation.messages.build(params[:message])
    @message.conversation_participant = @conversation.conversation_participants.find_by_user_id(current_user)

    respond_to do |format|
      if @message.save

        current_user.update_attribute(:last_read_messages_at, DateTime.now)
        logar(current_user)
        format.html do
          redirect_to @conversation, only_path: true
        end
      else
        format.html do
          flash[:error] = 'O campo Mensagem não pode ficar em branco'
          redirect_to @conversation, only_path: true
        end
      end

      format.js
    end
  end

  def show
    @message = Message.find(params[:id])
    fresh_when etag: @message, last_modified: @message.updated_at, public: true
    render partial: 'messages/message', locals: { message: @message }
  end
end
