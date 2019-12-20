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
  it "if a user has pending orders containing items I sell I see a list of those orders" do
    order
  end
  it "the order list includes order_id which is link to order show page, date created, total quantity of my items and total value for that order " do
  end
end
