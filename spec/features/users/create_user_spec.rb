require 'rails_helper'

RSpec.describe "create new users" do
  it "can create a new user" do
    visit '/merchants'
    click_on "Register"

    expect(current_path).to eq('/register')
    fill_in :name, with: "John Doe"
    fill_in :address, with: "42 West Street"
    fill_in :city, with: "Soloana"
    fill_in :state, with: "CA"
    fill_in :zip, with: "89897"
    fill_in :email, with: "go@foogle.com"
    fill_in :password, with: "notsecure123"
    fill_in :password_confirmation, with: "notsecure123"
    click_button "Submit"

    new_user = User.last
    expect("#{new_user.name}").to eq("John Doe")

    expect(current_path).to eq('/profile')
    expect(page).to have_content("Congratulations! You are now registered and logged in.")
  end
end
