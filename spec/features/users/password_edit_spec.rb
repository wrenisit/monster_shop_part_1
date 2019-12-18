require 'rails_helper'

RSpec.describe "password edit" do
  it "can update a user's password" do
    wilma = User.create(name: "Wilma White",
                               address: "7 RR 12",
                               city: "Dripping Springs",
                               state: "TX",
                               zip: 78620,
                               email: "fakemom@someplace.com",
                               password: "MangosAreTrash")

    visit '/login'
    fill_in :email, with: wilma.email
    fill_in :password, with: wilma.password
    click_button "Log In"

    expect(page).to have_link("Edit Your Password")
    click_link "Edit Your Password"

    expect(current_path).to eq('/profile/password')

    fill_in :password, with: "nottrash"
    fill_in :password_confirmation, with: "nottrash"
    click_button "Submit"

    expect(current_path).to eq('/profile')
    expect(page).to have_content("Your password has been updated.")

    click_link("Log Out")
    click_link("Log In")

    fill_in :email, with: wilma.email
    fill_in :password, with: "nottrash"
    click_button "Log In"

    expect(current_path).to eq('/profile')
  end
end
