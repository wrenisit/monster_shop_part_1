class Message < ApplicationRecord
  validates_presence_of :receiver_id, :sender_id, :title, :message

  belongs_to :user
  belongs_to :merchant
end
