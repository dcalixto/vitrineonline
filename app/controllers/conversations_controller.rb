# encoding: utf-8
class ConversationsController < ApplicationController
  before_filter :logado?, :authorize
  after_filter :update_user_last_read

  def index
    if current_user
      # @conversation = Conversation.new
      # @conversations = current_user.active_conversations
      # .includes(:conversation_participants,:display_message) #:users
      # .order('conversations.updated_at DESC').paginate(:page => params[:page], :per_page => 2)

      # #@conversation = Conversation.new

      @q = @conversations = current_user.active_conversations
                            .includes(:conversation_participants, :display_message) #:users
                            .order('conversations.updated_at DESC').ransack(params[:q])
      @conversations = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)

    else
      redirect_to root_url
    end
    # redirect_to fail_order_path if current_user.conversation.display_message.body.blank?
    if request.xhr?
      render partial: 'conversations/conversation', collection: @conversations
    end
    end

  def show
    
    @conversation = current_user.conversations.find(params[:id])
    @messages = @conversation.messages.order('created_at DESC') # .includes(:user).page(params[:page]).per_page(2)
    @participant = @conversation.conversation_participants.find_by_user_id(current_user)
    @participant.update_attribute(:has_read, true)
    @new_message = @conversation.messages.build



    #  if  params[:page]
    #  render partial: 'messages/message', collection: @messages
    #  end

    respond_to do |format|
      format.js { render partial: 'messages/message', collection: @messages, layout: false }
      format.html
    end
  end

  def participants
    @conversation = Conversation.find(params[:id])
    render partial: 'participants', locals: { conversation: @conversation }
  end



  def new

    if current_user

      @conversation = Conversation.new

  end
  end

  def create
    Conversation.transaction do
      @conversation = Conversation.create(params[:conversation])

      if @conversation
        if !params[:conversation_participants].nil?
          10.times { puts 'NOT NIL' }
          params[:conversation_participants].each do |_key, user_id|
            @conversation.conversation_participants.create(user_id: user_id)
          end
        else
          user = User.find_by_name(params[:conversation_participant][:name])
          if user.nil?
            flash[:error] = 'Usuário inexistente'
            fail ActiveRecord::Rollback
          end
          @conversation.conversation_participants.create(user_id: user.id)
        end

        this_cp = @conversation.conversation_participants.create(
          user_id: current_user.id,
          has_read: true
        )

        message = @conversation.messages.build(body: params[:message][:body], conversation_participant: this_cp)
        message.save
        current_user.update_attribute(:last_read_messages_at, DateTime.now)
        logar(current_user)
      end
    end

    redirect_to @conversation
  end

  private

  def update_user_last_read
    if current_user

      if current_user.unread_messages?
        current_user.update_attribute(:last_read_messages_at, Time.now)
        logar(current_user)
      end
    end
  end
end
