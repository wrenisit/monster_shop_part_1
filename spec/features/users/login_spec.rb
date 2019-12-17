require 'rails_helper'

RSpec.describe "As a visitor when I visit login path", type: :feature do
  describe "I see a field to enter my email address and password" do
    it "when I submit valid information I am redirected back to my profile page" do

      regular_user = User.create!(name: "Becky",
                                 address: "123 Main",
                                 city: "Broomfield",
                                 state: "CO",
                                 zip: 80020,
                                 email: "go@foogle.com",
                                 password: "notsecure123")

      visit '/merchants'
      click_on 'Log In'

      expect(current_path).to eq("/login")

      fill_in :email, with: "go@foogle.com"
      fill_in :password, with: "notsecure123"
      fill_in :password_confirmation, with: "notsecure123"
      click_button "Log In"

      expect(current_path).to eq("/profile")

      expect(page).to have_content("Welcome go@foogle.com")
    end

    it "won't login if password does not match" do

      new_user = create(:regular_user, email: "yo@gmail.com", password: "123password", password_confirmation: "123password")

      visit '/merchants'
      click_on 'Log In'

      expect(current_path).to eq("/login")

      fill_in :email, with: "yo@gmail.com"
      fill_in :password, with: "notsecure123"
      fill_in :password_confirmation, with: "notthesame"
      click_button "Log In"

      expect(current_path).to eq("/login")
      expect(page).to have_content("Sorry Invalid Password or Email.")
    end
    it "won't login if password isn't entered" do

      new_user = create(:regular_user, email: "yo@gmail.com", password: "123password", password_confirmation: "123password")

      visit '/merchants'
      click_on 'Log In'

      expect(current_path).to eq("/login")

      fill_in :email, with: "yo@gmail.com"
      fill_in :password, with: ""
      fill_in :password_confirmation, with: ""
      click_button "Log In"

      expect(current_path).to eq("/login")
      expect(page).to have_content("Sorry Invalid Password or Email.")
    end

    it "won't login if email does not match" do

      new_user = create(:regular_user, email: "yo@gmail.com", password: "123password", password_confirmation: "123password")

      visit '/merchants'
      click_on 'Log In'

      expect(current_path).to eq("/login")

      fill_in :email, with: "erwq@gmail.com"
      fill_in :password, with: "notsecure123"
      fill_in :password_confirmation, with: "notsecure123"
      click_button "Log In"

      expect(current_path).to eq("/login")
      expect(page).to have_content("Sorry Invalid Password or Email.")
    end

    xit "when I am a merchant user I am redirected to my merchant dashboard" do
    end

    xit "when I am an admin user I am redirected to my admin dashboard page" do
    end
  end
end
