require 'rails_helper'

RSpec.describe "message delete" do
  it "lets a user delete a message" do
    merchant = create(:jomah_merchant)
    merchant_user = create(:merchant_employee, merchant: merchant)
    wren = create(:regular_user, email: "rad1@gmail.com")
    item_1 = create(:random_item, merchant: merchant, inventory: 10)
    item_2 = create(:random_item, merchant: merchant, inventory: 5)

    order = create(:random_order, user: wren)
    item_order_1 = create(:item_order, order: order, item: item_1, price: item_1.price, quantity: 5)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(wren)

    visit "/profile/orders"
    within "#order-#{order.id}" do
      click_link "Order ID: #{order.id}"
    end
    expect(current_path).to eq("/profile/orders/#{order.id}")

    expect(page).to have_content("Order ID: #{order.id}")
    expect(page).to have_content(order.created_at)
    expect(page).to have_content(order.updated_at)
    expect(page).to have_content(order.status.capitalize)
    expect(page).to have_button("Message Merchant")
    click_on("Message Merchant")

    expect(current_path).to eq("/profile/messages/#{order.merchant.id}/new")

    fill_in :title, with: "Yuck!"
    fill_in :body, with: "I asked for mangos, not bananas!"
    click_button "Submit"
  end
end
