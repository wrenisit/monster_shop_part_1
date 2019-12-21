require 'rails_helper'

describe "admin order dashboard" do
  it "shows packaged orders and can ship them" do
    user = create(:regular_user)
    admin_user = create(:admin_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

    merchant = create(:jomah_merchant)
    items = create_list(:random_item, 5, merchant: merchant, inventory: 10)
    order = create(:random_order, user: user)
    items.each do |item|
      create(:item_order, order: order, item: item, price: item.price, quantity: 5)
    end

    visit "/admin/dashboard"
  end
end