require 'rails_helper'

RSpec.describe "edit user info" do
  it "has an edit page with prepoulated data" do

    regular_user = User.create!(name: "Becky",
                               address: "123 Main",
                               city: "Broomfield",
                               state: "CO",
                               zip: 80020,
                               email: "go@foogle.com",
                               password: "notsecure123")
    this_regular_user = User.create!(name: "Jimmy",
                              address: "3 Bronco Rd",
                              city: "Hye",
                              state: "TX",
                              zip: 78737,
                              email: "j@c.com",
                              password: "mypassword")

    visit '/merchants'
    click_on 'Log In'

    expect(current_path).to eq("/login")

    fill_in :email, with: "go@foogle.com"
    fill_in :password, with: "notsecure123"
    fill_in :password_confirmation, with: "notsecure123"
    click_button "Log In"

    expect(current_path).to eq("/profile")
    click_link "Edit Your Profile"

    expect(current_path).to eq("/profile/edit")

    fill_in :name, with: "Sigourney Weaver"
    fill_in :address, with: "666 Meyers Lane"
    click_button "Submit"

    expect(page).to have_content("Sigourney Weaver")
    expect(page).to have_content("666 Meyers Lane")
    expect(page).to have_content(regular_user.city)
    expect(page).to have_content(regular_user.state)
    expect(page).to have_content(regular_user.zip)
    expect(page).to have_content(regular_user.email)

    click_link "Log Out"
    click_link "Log In"

    fill_in :email, with: this_regular_user.email
    fill_in :password, with: this_regular_user.password
    fill_in :password_confirmation, with: this_regular_user.password
    click_button "Log In"

    expect(page).to have_content(this_regular_user.name)
    expect(page).to have_content(this_regular_user.address)
    expect(page).to have_content(this_regular_user.city)
    expect(page).to have_content(this_regular_user.state)
    expect(page).to have_content(this_regular_user.zip)
    expect(page).to have_content(this_regular_user.email)
  end
end

# As a registered user
# When I visit my profile page
# I see a link to edit my profile data
# When I click on the link to edit my profile data
# I see a form like the registration page
# The form is prepopulated with all my current information except my password
# When I change any or all of that information
# And I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my data is updated
# And I see my updated information