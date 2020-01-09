require 'rails_helper'

RSpec.describe "message delete" do
  it "lets a user delete a message" do
    merchant = create(:jomah_merchant)
    merchant_user = create(:merchant_employee, merchant: merchant)

    wren = create(:regular_user, email: "rad1@gmail.com")
    message_1 = Message.create(merchant_id: merchant.id, user_id: wren.id, title: "Order Delayed", body: "Hello. Due to a shipping delay, your order will not ship until July 12th. Thank you for your patience.", sender_id: merchant.id)
    message_2 = Message.create(merchant_id: merchant.id, user_id: wren.id, title: "Order Shipped", body: "Hello. Thanks for shipping it.", sender_id: wren.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(wren)

    visit "/profile/messages/#{message_1.id}"
    click_button("Delete")

    expect(current_path).to eq("/profile/messages")
    expect(page).not_to have_link(message_1.title)

    click_on "Log Out"
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)
    visit "/merchants/#{merchant.id}/messages/#{message_2.id}"
    click_button("Delete")

    expect(current_path).to eq("/merchants/#{merchant.id}/messages")
    expect(page).not_to have_link(message_2.title)

  end
end
