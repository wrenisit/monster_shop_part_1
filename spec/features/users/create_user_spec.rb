require 'rails_helper'

RSpec.describe "create new users" do
  it "can create a new user" do
    visit '/merchants'
    click_on "Register"

    expect(current_path).to eq('/register')
    fill_in :name, with: "John Doe"
    fill_in :street, with: "42 West Street"
    fill_in :state, with: "CA"
    fill_in :zip, with: "89897"
    fill_in :email, with: "go@foogle.com"
    fill_in :password, with: "notsecure123"
    fill_in :password_confirmation, with: "notsecure123"
    click_button "Create User"

    expect(current_path).to eq('/profile')
    expect(page).to have_content("Congratulations! You are now registered and logged in.")
  end
end
# As a visitor
# When I click on the 'register' link in the nav bar
# Then I am on the user registration page ('/register')
# And I see a form where I input the following data:
#
# my name
# my street address
# my city
# my state
# my zip code
# my email address
# my preferred password
# a confirmation field for my password
# When I fill in this form completely,
# And with a unique email address not already in the system
# My details are saved in the database
# Then I am logged in as a registered user
# I am taken to my profile page ("/profile")
# I see a flash message indicating that I am now registered and logged in
