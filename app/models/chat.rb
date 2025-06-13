class Chat < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  has_many :messages, dependent: :destroy

  validates :sender_id, presence: true
  validates :receiver_id, presence: true

  validate :sender_is_not_receiver

  scope :for_user, ->(user) { where("sender_id = ? OR receiver_id = ?", user.id, user.id) }

  def chat_participants
    "Chat between #{sender.full_name} and #{receiver.full_name}"
  end

  def other_participant(current_user)
    if sender == current_user
      receiver
    else
      sender
    end
  end

  private

  def sender_is_not_receiver
    if sender_id.present? && receiver_id.present? && sender_id == receiver_id
      errors.add(:receiver_id, "cannot be the same as the sender")
    end
  end
end
