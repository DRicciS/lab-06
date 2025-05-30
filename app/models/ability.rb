# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    user ||= User.new # guest user (not logged in) - gives them no permissions by default

    if user.persisted? # Check if the user is a persisted record (logged in)
      # All logged-in users can read all resources
      can :read, :all # Includes User, Chat, Message

      # User abilities
      can :manage, User, id: user.id # A user can manage their own profile (edit, update)
      # Note: Devise handles registration and password.
      # For 'destroy', you might want admin-only.

      # Chat abilities
      can :create, Chat
      # A user can manage chats they are part of (sender or receiver)
      can [ :update, :destroy ], Chat, sender_id: user.id
      can [ :update, :destroy ], Chat, receiver_id: user.id
      # Note: :read for Chat is covered by `can :read, :all` for logged-in users.

      # Message abilities
      can :create, Message # Any logged-in user can create a message
      # A user can manage messages they sent
      can [ :update, :destroy ], Message, user_id: user.id
      # A user can also read messages in chats they participate in (covered by `can :read, :all` and Chat read access)

      # If you had an admin role, you would define it here:
      # if user.admin?
      #   can :manage, :all
      # end
    else
      # Guest users (not logged in)
      # can :read, SomePublicModel # If you have any public pages/models
      # For example, if you want the users index and show pages to be public:
      # can :read, User # If you want guests to see user list/profiles
    end
  end
end
