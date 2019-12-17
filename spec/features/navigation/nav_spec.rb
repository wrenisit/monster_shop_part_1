require 'rails_helper'

describe 'the navigation bar' do
  it "shows these links for a visitor" do
    visit "/"
    click_link "Home"
    expect(current_path).to eq "/"

    visit "/"
    click_link "Items"
    expect(current_path).to eq "/items"

    visit "/"
    click_link "Merchants"
    expect(current_path).to eq "/merchants"

    visit "/"
    click_link "Cart"
    expect(current_path).to eq "/cart"

    visit "/"
    click_link "Log In"
    expect(current_path).to eq "/login"

    visit "/"
    click_link "Register"
    expect(current_path).to eq "/register"
  end
end