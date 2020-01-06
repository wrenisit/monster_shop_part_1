require 'rails_helper'

describe "merchant order show page" do
  before :each do
    @user = create(:regular_user)
    @merchant_user = create(:merchant_employee)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)

    @jomah = create(:jomah_merchant)
    @ray = create(:ray_merchant)
    @order = create(:random_order, user: @user)

    @item_1 = create(:random_item, merchant: @jomah, inventory: 10)
    create(:item_order, order: @order, item: @item_1, price: @item_1.price, quantity: 5)
    @item_2 = create(:random_item, merchant: @jomah, inventory: 5)
    create(:item_order, order: @order, item: @item_2, price: @item_2.price, quantity: 6)
    @item_3 = create(:random_item, merchant: @ray, inventory: 10)
    create(:item_order, order: @order, item: @item_3, price: @item_3.price, quantity: 5)
  end

  it 'shows the customers name and address' do
    visit "/merchant/orders/#{@order.id}"

    within "#order-data" do
      expect(page).to have_content @user.name
      expect(page).to have_content @user.address
      expect(page).to have_content @user.city
      expect(page).to have_content @user.state
      expect(page).to have_content @user.zip
    end
  end


end