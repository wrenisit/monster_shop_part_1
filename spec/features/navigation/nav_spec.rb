require "rails_helper"

describe "the navigation bar" do
  it "shows these links for a visitor" do
    visit "/"

    within ".topnav" do
      click_link "Home"
    end
    expect(current_path).to eq "/"

    within ".topnav" do
      click_link "All Items"
    end
    expect(current_path).to eq "/items"

    within ".topnav" do
      click_link "All Merchants"
    end
    expect(current_path).to eq "/merchants"

    item = create(:random_item)
    visit "/items/#{item.id}"
    click_button "Add To Cart"
    within ".topnav" do
      click_link "Cart: 1"
    end
    expect(current_path).to eq "/cart"

    within ".topnav" do
      click_link "Register"
    end
    expect(current_path).to eq "/register"

    within ".topnav" do
      click_link "Log In"
    end
    expect(current_path).to eq "/login"
  end

  it "shows additional links for a user" do
    visit "/"
    within ".topnav" do
      expect(page).to have_link "Home"
      expect(page).to have_link "All Items"
      expect(page).to have_link "All Merchants"
      expect(page).to have_link "Cart: 0"
      expect(page).to have_link "Register"
      click_link "Log In"
    end

    user = create(:regular_user, password: "vsecure")
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log In"

    within ".topnav" do
      expect(page).to have_link "Home"
      expect(page).to have_link "All Items"
      expect(page).to have_link "All Merchants"
      expect(page).to have_link "Cart: 0"
      expect(page).not_to have_link "Log In"
      expect(page).not_to have_link "Register"
    end

    within ".topnav" do
      click_link "My Profile"
    end
    expect(current_path).to eq "/profile"
    expect(page).to have_content "You are logged in as #{user.name}"

    within ".topnav" do
      click_link "Log Out"
    end
  end

  it "has additional links for a merchant" do
    visit "/"
    within ".topnav" do
      expect(page).to have_link "Home"
      expect(page).to have_link "All Items"
      expect(page).to have_link "All Merchants"
      expect(page).to have_link "Cart: 0"
      expect(page).to have_link "Register"
      click_link "Log In"
    end

    user = create(:merchant_employee, password: "vsecure")
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log In"

    within ".topnav" do
      expect(page).to have_link "Home"
      expect(page).to have_link "All Items"
      expect(page).to have_link "All Merchants"
      expect(page).to have_link "Cart: 0"
      expect(page).to have_link "Merchant Dashboard"
      expect(page).not_to have_link "Log In"
      expect(page).not_to have_link "Register"
    end
  end
end