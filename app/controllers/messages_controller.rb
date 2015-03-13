class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    
  end

  def create
    recipient = User.find(params['recipient'])
    body = params[:message][:body]
    subject = params[:message][:subject]
    current_user.send_message(recipient, body, subject).conversation
    flash[:success] = "Message sent!"
    redirect_to :back
  end
end
