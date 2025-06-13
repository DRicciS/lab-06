# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    # Guest user (not logged in)
    user ||= User.new

    # Rules for all logged-in users
    if user.persisted?
      # Check if the user has the 'admin' flag set to true
      if user.admin?
        # --- ADMIN PERMISSIONS ---
        can :manage, :all # Admins can perform any action on any model

      else
        # --- REGULAR (NON-ADMIN) USER PERMISSIONS ---

        # User Permissions:
        # A regular user can only view a profile page (:show).
        # They CANNOT view the user list page (:index).
        can :show, User
        # A user can manage (update, destroy) their OWN profile.
        can :manage, User, id: user.id

        # Chat Permissions:
        # They can create new chats.
        can :create, Chat
        # They can only read chats where they are the sender or receiver.
        can :read, Chat, sender_id: user.id
        can :read, Chat, receiver_id: user.id
        # They can only manage chats where they are the sender or receiver.
        can [ :update, :destroy ], Chat, sender_id: user.id
        can [ :update, :destroy ], Chat, receiver_id: user.id

        # Message Permissions:
        # They can create new messages.
        can :create, Message
        # Let's assume they can read any message if they can access the chat.
        can :read, Message
        # They can only manage messages they sent themselves.
        can [ :update, :destroy ], Message, user_id: user.id
      end
    end
  end
end
