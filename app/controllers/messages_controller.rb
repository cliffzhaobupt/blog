class MessagesController < ApplicationController
  MessagePerPage = 10

  # list of messages posted to one user
  def list
    @user = User.find(params[:id])
    @current_page = Integer(params[:page] || 1)
    @page_count = (@user.received_messages.size / Float(MessagePerPage)).ceil
    @messages = @user.received_messages
      .order('created_at DESC')
      .offset((@current_page - 1) * MessagePerPage)
      .limit(MessagePerPage)

    if params[:onlymessage] == 'true'
      render 'listonlymessage', layout: false
    end
  end

  # post message to one user
  def add
    message = Message.new(message_params)
    message.save
    
    @user = User.find(params[:message][:receiver_id])
    @current_page = 1
    @page_count = (@user.received_messages.size / Float(MessagePerPage)).ceil
    @messages = @user.received_messages
      .order('created_at DESC')
      .limit(MessagePerPage)

    unless message.receiver_id == message.sender_id
      @user.notifications.create(
        notification_type: 'message'
      )
    end

    if message.reply_to
      message.reply_to.sender.notifications.create(
        notification_type: 'message_reply',
        item_id: message.reply_to.receiver_id
        )
    end

    render 'listonlymessage', layout: false
  end

  private
    # white list method
    def message_params
      params[:message][:sender_id] = params[:message][:sender_id].to_i
      params[:message][:receiver_id] = params[:message][:receiver_id].to_i
      params[:message][:content] = params[:message][:content].chomp
      params.require(:message).permit(:sender_id, :receiver_id, :content, :reply_to_id)
    end
end
