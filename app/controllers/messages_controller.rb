class MessagesController < ApplicationController
  before_action :set_message, only: [ :show, :edit, :update ]
  before_action :load_users_and_chats, only: [ :new, :create, :edit, :update ]

  def index
    @messages = Message.all
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to @message.chat, notice: "Message was successfully sent."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @message.update(message_params)
      redirect_to @message, notice: "Message was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  private

  def set_message # New method
    @message = Message.find(params[:id])
  end

  def load_users_and_chats # New method
    @users = User.all
    @chats = Chat.all
  end

  def message_params
    params.require(:message).permit(:user_id, :chat_id, :body)
  end
end
