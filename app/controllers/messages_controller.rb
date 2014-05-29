class MessagesController < ApplicationController
  MessagePerPage = 10

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

  def add
    message = Message.new(message_params)
    message.save
    
    @user = User.find(params[:message][:receiver_id])
    @current_page = 1
    @page_count = (@user.received_messages.size / Float(MessagePerPage)).ceil
    @messages = @user.received_messages
      .order('created_at DESC')
      .limit(MessagePerPage)

    render 'listonlymessage', layout: false
  end

  private
    def message_params
      params[:message][:sender_id] = params[:message][:sender_id].to_i
      params[:message][:receiver_id] = params[:message][:receiver_id].to_i
      params[:message][:content] = params[:message][:content].chomp
      params.require(:message).permit(:sender_id, :receiver_id, :content, :reply_to_id)
    end
end
