class Message < ApplicationRecord
  validates_presence_of :merchant_id, :user_id, :title, :body

  belongs_to :user
  belongs_to :merchant

  enum status: %w(unread read)
end
