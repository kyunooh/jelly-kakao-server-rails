class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :chat_room_members
end
