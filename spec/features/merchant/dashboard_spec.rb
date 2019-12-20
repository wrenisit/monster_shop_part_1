require 'rails_helper'

describe "merchant dashboard" do
  it "should show the merchant user's info" do
    merchant_employee = create(:merchant_employee)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_employee)

    visit "/merchant"

    expect(page).to have_content merchant_employee.name
    expect(page).to have_content merchant_employee.address
    expect(page).to have_content merchant_employee.city
    expect(page).to have_content merchant_employee.state
    expect(page).to have_content merchant_employee.zip
  end
end