# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource # Add this line

  # before_action :set_message, only: [:show, :edit, :update] # Likely redundant
  before_action :load_users_and_chats, only: [ :new, :create, :edit, :update ] # Keep for your forms

  def index
    # @messages is populated
  end

  def show
    # @message is loaded and authorized
  end

  def new
    # @message is initialized
  end

  def edit
    # @message is loaded and authorized
  end

  def create
    # @message is built by load_and_authorize_resource with message_params.
    # It's good practice to explicitly set the user for the message:
    @message.user = current_user # Ensures the message is associated with the logged-in user

    if @message.save
      redirect_to @message.chat, notice: "Message was successfully sent."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # @message is loaded and authorized
    if @message.update(message_params)
      redirect_to @message, notice: "Message was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # def set_message # Consider removing
  #   @message = Message.find(params[:id])
  # end

  def load_users_and_chats
    @users = User.all
    @chats = Chat.all
  end

  def message_params
    # If user_id is part of the form, ensure it's handled correctly or removed
    # if you always assign current_user. Your current ability rule is:
    # can [:update, :destroy], Message, user_id: user.id
    # So for update, user_id in params is not strictly needed if @message is already scoped.
    params.require(:message).permit(:user_id, :chat_id, :body)
  end
end
