require 'rails_helper'

RSpec.describe "User replies" do
  it "allows a user to respond" do
    merchant = create(:jomah_merchant)
    regular_user = User.create(name: "Becky",
                               address: "123 Main",
                               city: "Broomfield",
                               state: "CO",
                               zip: 80020,
                               email: "goble@foogle.com",
                               password: "notsecure123",
                               role: 1,
                               merchant_id: merchant)
    wren = create(:regular_user, email: "rad1@gmail.com")
    message_1 = Message.create(merchant_id: merchant.id, user_id: wren.id, title: "Order Delayed", body: "Hello. Due to a shipping delay, your order will not ship until July 12th. Thank you for your patience.", sender_id: merchant.id)
    message_2 = Message.create(merchant_id: merchant.id, user_id: wren.id, title: "Order Shipped", body: "Hello. Your order has shipped.", sender_id: merchant.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(wren)

    visit "/profile/messages/#{message_2.id}"
    expect(page).to have_content(message_2.title)
    expect(page).to have_content(message_2.created_at)
    expect(page).to have_content("Sender: #{message_2.merchant.name}")
    expect(page).to have_content(message_2.body)
    click_button("Reply")

    expect(current_path).to eq("/profile/messages/#{message_2.merchant.id}/new")

    fill_in :title, with: "Thanks!"
    fill_in :body, with: "I can't wait to get my goods!"
    click_button "Submit"

    expect(current_path).to eq("/profile/messages")
    expect(page).to have_content("Your message has been sent.")

    message_3 = Message.last

    within "#message-#{message_1.id}" do
      expect(page).to have_content("unread")
    end

    within "#message-#{message_2.id}" do
      expect(page).to have_content("read")
    end

    click_on "Log Out"
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(regular_user)

    visit "/merchant"
    expect(page).to have_content("Messages: ")
    expect(page).to have_link("1")
    click_link("1")

    expect(current_path).to eq("/merchant/messages")
    within "#message-#{message_3.id}" do
      expect(page).to have_content(merchant.name)
      expect(page).to have_content(message_3.status)
      expect(page).to have_link(message_3.title)
      click_link("#{message_3.title}")
    end
    expect(current_path).to eq("/merchant/messages/#{message_3.id}")
    expect(page).to have_content(message_3.title)
    expect(page).to have_content(message_3.created_at)
    expect(page).to have_content("Sender: #{message_3.merchant.name}")
    expect(page).to have_content(message_3.body)
  end
end
