class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update] # Added :edit, :update
  before_action :load_users, only: [:new, :create, :edit, :update] # For dropdowns

  def index
    @chats = Chat.all
  end

  def show
  end

  def new
    @chat = Chat.new
  end

  def edit
  end

  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      redirect_to @chat, notice: "Chat was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @chat.update(chat_params)
  redirect_to @chat, notice: "Chat was successfully updated."
    else
  render :edit, status: :unprocessable_entity
  end
end
private

  def set_chat # New method
    @chat = Chat.find(params[:id])
  end

  def load_users # New method
    @users = User.all
  end

  def chat_params
    params.require(:chat).permit(:sender_id, :receiver_id)
  end
end