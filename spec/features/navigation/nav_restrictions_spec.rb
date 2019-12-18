require 'rails_helper'

describe "user navigation" do
  it "restricts access to visitors" do
    visit "/merchant"
    expect(page).to have_content "The page you were looking for doesn't exist."

    visit "/admin"
    expect(page).to have_content "The page you were looking for doesn't exist."

    visit "/profile"
    expect(page).to have_content "The page you were looking for doesn't exist."
  end
end