class ConversationsController < ApplicationController

  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :get_conversation, except: [:index]
  helper_method :mailbox, :conversation


  def index
    @inbox = @mailbox.inbox.page(params[:ipage]).per(10)
    @trash = @mailbox.trash.page(params[:tpage]).per(10)
    @sent  = @mailbox.sentbox.page(params[:spage]).per(10)

    respond_to do |format|
      format.js
      format.html 
    end
  end

  def show 
    # @conversation.mark_as_read(current_user)
  end

  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    flash[:success] = 'Reply sent'
    redirect_to conversation_path(@conversation)
  end

  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    redirect_to conversation_path(@conversation)
  end

  def trash
    flash[:notice] = 'Conversation moved to trash'
    @conversation.move_to_trash(current_user)
    redirect_to conversations_path
  end

  def untrash
    @conversation.untrash(current_user)
    redirect_to conversations_path
  end

  def destroy
    @conversation.mark_as_deleted(current_user)
    flash[:notice] = 'Conversation removed'
    redirect_to :conversations
  end

  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = 'Your trash was cleaned!'
    redirect_to conversations_path
  end

  # def mark_as_read
  #   @conversation.mark_as_read(current_user)
  #   flash[:success] = 'The conversation was marked as read.'
  #   redirect_to conversations_path
  # end

private 

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end

  # def show
  # end
  
  # def create
  #   recipient_usernames = conversation_params(:recipients).split(',')
  #   recipients = User.where(username: recipient_usernames).all

  #   conversation = current_user.
  #     send_message(recipients, *conversation_params(:body, :subject)).conversation

  #   redirect_to conversation_path(conversation)
  # end

  # def destroy
  #   conversation.mark_as_deleted(current_user)
  #   flash[:notice] = 'Conversation removed'
  #   redirect_to :conversations
  # end

  # def reply
  #   current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
  #   redirect_to conversation_path(conversation)
  # end

  # def trash
  #   conversation.move_to_trash(current_user)
  #   redirect_to :conversations
  # end

  # def untrash
  #   conversation.untrash(current_user)
  #   redirect_to :conversations
  # end

  # private

  # def mailbox
  #   @mailbox ||= current_user.mailbox
  # end

  # def conversation
  #   @conversation ||= mailbox.conversations.find(params[:id])
  # end

  # def conversation_params(*keys)
  #   fetch_params(:conversation, *keys)
  # end

  # def message_params(*keys)
  #   fetch_params(:message, *keys)
  # end

  # def fetch_params(key, *subkeys)
  #   params[key].instance_eval do
  #     case subkeys.size
  #     when 0 then self
  #     when 1 then self[subkeys.first]
  #     else subkeys.map{|k| self[k] }
  #     end
  #   end
  # end

end
