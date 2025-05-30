# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource # Add this line

  # Your existing `before_action :set_user, only: [:show, :edit, :update]`
  # might become redundant for :show, :edit, :update as load_and_authorize_resource
  # will define @user. You can test and remove it if so.
  # Keep it if you have custom logic in set_user that load_and_authorize_resource doesn't cover.
  # For now, let's assume load_and_authorize_resource handles it.
  # You can comment out or remove your set_user method if it only did User.find(params[:id]).

  def index
    # load_and_authorize_resource populates @users with User.accessible_by(current_ability)
    # This is usually what you want. Your existing @users = User.includes(:messages).all might
    # bypass some authorization or load more than authorized.
    # For now, rely on what load_and_authorize_resource provides for @users.
    # If you need includes(:messages), you can do:
    # @users = @users.includes(:messages)
  end

  def show
    # @user is loaded and authorized by load_and_authorize_resource
  end

  def new
    # @user is initialized by load_and_authorize_resource (e.g., User.new)
  end

  def edit
    # @user is loaded and authorized
  end

  def create
    # @user is built by load_and_authorize_resource with params, e.g. User.new(user_params)
    # You might need to assign current_user if it's not automatically associated,
    # though Devise handles current_user for its own registration.
    # For user creation by other users (if allowed by Ability):
    # @user.some_creator_attribute = current_user if needed
    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # @user is loaded and authorized
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # def set_user # Consider removing if load_and_authorize_resource is sufficient
  #   @user = User.find(params[:id])
  # end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
