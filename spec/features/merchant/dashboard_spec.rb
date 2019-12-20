require 'rails_helper'

describe "merchant dashboard" do
  it "should show the merchant user's info" do
    merchant_employee = create(:merchant_employee)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_employee)

    visit "/merchant"
    expect(page).to have_content merchant_employee.merchant.name
    expect(page).to have_content merchant_employee.merchant.address
    expect(page).to have_content merchant_employee.merchant.city
    expect(page).to have_content merchant_employee.merchant.state
    expect(page).to have_content merchant_employee.merchant.zip
  end

  describe "setting up orders" do
    before :each do
        @item_1 = create(:random_item)
        @item_2 = create(:random_item)
        @item_3 = create(:random_item)
        @item_4 = create(:random_item)
        @merchant = create(:merchant_employee)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

        visit "/items/#{@item_1.id}"
        click_on "Add To Cart"
        visit "/items/#{@item_2.id}"
        visit "/cart"
        click_on "Checkout"
        fill_in 'Name', with: @merchant.name
        fill_in 'Address', with: @merchant.address
        fill_in 'City', with: @merchant.city
        fill_in 'State', with: @merchant.state
        fill_in 'Zip', with: @merchant.zip

        click_on "Create Order"

        visit "/items/#{@item_3.id}"
        click_on "Add To Cart"
        visit "/items/#{@item_4.id}"
        click_on "Add To Cart"
        visit "/cart"
        click_on "Checkout"

        fill_in 'Name', with: @merchant.name
        fill_in 'Address', with: @merchant.address
        fill_in 'City', with: @merchant.city
        fill_in 'State', with: @merchant.state
        fill_in 'Zip', with: @merchant.zip
        click_on "Create Order"
      end

      it "if a user has pending orders containing items I sell I see a list of those orders" do

        visit "/merchant"

        order_1 = @merchant.orders.first
        order_2 = @merchant.orders.last
        items_1 = order_1.items
        items_1 = order_2.items
        within("#order-#{order_1.id}") do
          expect(page).to have_link(order_1.id)
          expect(page).to have_content(order_1.created_at)
          expect(page).to have_content(items_1.size)
        end
      end

      it "the order list includes order_id which is link to order show page, date created, total quantity of my items and total value for that order " do
      end
  end
end
