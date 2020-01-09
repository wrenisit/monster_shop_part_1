require 'rails_helper'

describe Message, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should validate_presence_of :merchant_id}
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :sender_id }
    it { should define_enum_for(:status).with_values([:unread, :read]) }

  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should belong_to(:user) }
  end

end
