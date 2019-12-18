require "rails_helper"

describe "the navigation bar" do
  it "shows these links for a visitor" do
    visit "/"
    click_link "Home"
    expect(current_path).to eq "/"

    visit "/"
    click_link "All Items"
    expect(current_path).to eq "/items"

    visit "/"
    click_link "All Merchants"
    expect(current_path).to eq "/merchants"

    item = create(:random_item)
    visit "/items/#{item.id}"
    click_button "Add To Cart"
    visit "/"
    click_link "Cart: 1"
    expect(current_path).to eq "/cart"

    visit "/"
    click_link "Log In"
    expect(current_path).to eq "/login"

    visit "/"
    click_link "Register"
    expect(current_path).to eq "/register"
  end

  it "shows additional links for a user" do
    visit "/"
    click_link "Home"
    expect(current_path).to eq "/"

    visit "/"
    click_link "All Items"
    expect(current_path).to eq "/items"

    visit "/"
    click_link "All Merchants"
    expect(current_path).to eq "/merchants"

    item = create(:random_item)
    visit "/items/#{item.id}"
    click_button "Add To Cart"
    visit "/"
    click_link "Cart: 1"
    expect(current_path).to eq "/cart"

    visit "/"
    click_link "Register"
    expect(current_path).to eq "/register"

    visit "/"
    click_link "Log In"
    expect(current_path).to eq "/login"

    user = create(:regular_user, password: "vsecure")
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log In"

    within ".topnav" do
      expect(page).not_to have_link "Log In"
      expect(page).not_to have_link "Register"
    end

    within ".topnav" do
      click_link "My Profile"
    end
    expect(current_path).to eq "/profile"

    within ".topnav" do
      click_link "Log Out"
    end

    expect(page).to have_content "Welcome #{user.email}"
  end
end