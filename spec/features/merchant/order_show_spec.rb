require 'rails_helper'

describe "merchant order show page" do
  it "allows merchant users to fulfill orders" do
    user = create(:regular_user)
    merchant_user = create(:merchant_employee)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

    merchant = create(:jomah_merchant)
    items = create_list(:random_item, 5, merchant: merchant, inventory: 10)
    order = create(:random_order, user: user)
    items.each do |item|
      create(:item_order, order: order, item: item, price: item.price, quantity: 5)
    end

    visit merchant_order_path(order)
    click_link "Fulfill Order"
    epxect(Order.first.packaged?).to be true
  end
end