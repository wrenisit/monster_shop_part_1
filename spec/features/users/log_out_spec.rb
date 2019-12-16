require 'rails_helper'

RSpec.describe "log out user" do
  it "can log out the user" do
    visit '/merchants'
    click_on "Register"

    expect(current_path).to eq('/register')
    fill_in :name, with: "Charley Mae"
    fill_in :address, with: "4 Bunker Ln"
    fill_in :city, with: "Lebanon"
    fill_in :state, with: "KS"
    fill_in :zip, with: 55555
    fill_in :email, with: "mol@google.com"
    fill_in :password, with: "notsecure123"
    fill_in :password_confirmation, with: "notsecure123"
    click_button "Submit"

    new_user = User.last
    expect("#{new_user.name}").to eq("Charley Mae")
    expect(current_path).to eq('/profile')
    click_button("Log Out")
    expect(current_path).to eq('/')
    expect(page).to have_content("You are now logged out.")
  end
end
