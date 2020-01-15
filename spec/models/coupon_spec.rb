require 'rails_helper'

describe Coupon, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :amount }
    it { should validate_presence_of :merchant }
  end

  describe "relationships" do
    it {should belong_to :merchant}
  end
end
