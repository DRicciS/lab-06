class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
    @users = User.all
    @chats = Chat.all  
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to @message.chat, notice: "Message was successfully sent."
    else
      @users = User.all 
      @chats = Chat.all 
      render :new, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :chat_id, :body)
  end
end