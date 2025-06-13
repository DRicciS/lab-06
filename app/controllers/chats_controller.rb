# app/controllers/chats_controller.rb
class ChatsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource # Add this line

  # before_action :set_chat, only: [:show, :edit, :update] # Likely redundant
  before_action :load_users, only: [ :new, :create, :edit, :update ] # Keep for your forms

    def index
    @chats = Chat.for_user(current_user).order(created_at: :desc)
    end

  def show
    # @chat is loaded and authorized
  end

  def new
    # @chat is initialized (Chat.new)
    # @users is loaded by your before_action
  end

  def edit
    # @chat is loaded and authorized
    # @users is loaded by your before_action
  end

  def create
    # @chat is built with chat_params.
    # You might need to manually assign sender if not handled by associations
    # or if you want to enforce current_user as sender.
    # For instance, if your chat_params doesn't include sender_id or you want to override:
    # @chat.sender = current_user
    # However, your form allows selecting sender_id. The authorization rules should handle this.

    if @chat.save
      redirect_to @chat, notice: "Chat was successfully created."
    else
      # @users is re-loaded by your before_action if render :new
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # @chat is loaded and authorized
    if @chat.update(chat_params)
      redirect_to @chat, notice: "Chat was successfully updated."
    else
      # @users is re-loaded by your before_action if render :edit
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # def set_chat # Consider removing
  #   @chat = Chat.find(params[:id])
  # end

  def load_users
    @users = User.all
  end

  def chat_params
    params.require(:chat).permit(:sender_id, :receiver_id)
  end
end
