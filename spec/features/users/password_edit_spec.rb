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
    expect(page).to have_content("Your Password Has Been Updated")
  end
end
# As a registered user
# When I visit my profile page
# I see a link to edit my password
# When I click on the link to edit my password
# I see a form with fields for a new password, and a new password confirmation
# When I fill in the same password in both fields
# And I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my password is updated
