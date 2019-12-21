require 'rails_helper'

describe "admin order dashboard" do
  it "shows packaged orders and can ship them" do
    user = create(:regular_user)
    admin_user = create(:admin_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

    merchant = create(:jomah_merchant)
    order = create(:random_order, user: user, status: "pending")
    order_2 = create(:random_order, user: user, status: "packaged")

    visit "/admin"

    expect(page).to have_content "#{order.name}"
    expect(page).to have_content "#{order_2.name}"
  end
end