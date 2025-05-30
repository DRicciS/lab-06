class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :messages, foreign_key: :user_id, dependent: :destroy, inverse_of: :user
    has_many :sent_chats, class_name: 'Chat', foreign_key: 'sender_id', dependent: :destroy, inverse_of: :sender
    has_many :received_chats, class_name: 'Chat', foreign_key: 'receiver_id', dependent: :destroy, inverse_of: :receiver
    has_many :messages_in_received_chats, through: :received_chats, source: :messages

    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :first_name, presence: true
    validates :last_name, presence: true

    def full_name
      "#{first_name} #{last_name}"
    end
  end