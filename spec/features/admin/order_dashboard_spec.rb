require 'rails_helper'

describe "admin order dashboard" do
  it "shows packaged orders and can ship them" do
    user_1 = create(:random_user)
    user_2 = create(:random_user)
    admin_user = create(:admin_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

    merchant = create(:jomah_merchant)
    order_1 = create(:random_order, user: user_1, status: "pending")
    order_2 = create(:random_order, user: user_2, status: "packaged")
    order_3 = create(:random_order, user: user_1, status: "shipped")
    order_4 = create(:random_order, user: user_2, status: "cancelled")

    visit "/admin"
  end
end