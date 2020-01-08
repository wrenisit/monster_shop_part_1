require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  it "can search for an item" do
    visit "/"

    within 'nav' do
      expect(page).to have_content("Search")
      fill_in :search, with: "Enormous"
      click_on "Search"
    end
    expect(current_path).to eq(search_index_path)
  end
end
