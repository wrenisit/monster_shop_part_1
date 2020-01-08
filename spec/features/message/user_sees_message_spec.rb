require 'rails_helper'

RSpec.describe "user sees message" do
  it "shows messages on user dashboard" do
    merchant = create(:jomah_merchant)
    wren = create(:regular_user, email: "rad1@gmail.com")
    becky = create(:regular_user, email: "rad2@gmail.com")
    message_1 = Message.create(merchant_id: merchant.id, user_id: wren.id, title: "Order Delayed", body: "Hello. Due to a shipping delay, your order will not ship until July 12th. Thank you for your patience.")
    message_2 = Message.create(merchant_id: merchant.id, user_id: wren.id, title: "Order Shipped", body: "Hello. Your order has shipped.")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(wren)

    visit "/profile"
    expect(page).to have_content("Messages: ")
    expect(page).to have_link("2")
    click_link("2")
    expect(current_path).to eq("/profile/messages")
    within "#message-#{message_1.id}" do
      expect(page).to have_content(merchant.name)
      expect(page).to have_content(message_1.status)
      expect(page).to have_link(message_1.title)
    end
    within "#message-#{message_2.id}" do
      expect(page).to have_content(merchant.name)
      expect(page).to have_content(message_2.status)
      expect(page).to have_link(message_2.title)
      click_link("#{message_2.title}")
    end
    expect(current_path).to eq("/profile/messages/#{message_2.id}")
    expect(page).to have_content(message_2.title)
    expect(page).to have_content(message_2.date_created)
    expect(page).to have_content("Sender: #{message_2.merchant.name}")
    expect(page).to have_content(message_2.description)

  end
end
