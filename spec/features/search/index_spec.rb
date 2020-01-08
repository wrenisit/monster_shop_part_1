require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  it "can search for an item" do
    item_1 = create(:random_item, name: "Socks Forever Long")
    item_2 = create(:random_item, name: "Long John Silvers")
    item_3 = create(:random_item, name: "Favorite Sock Fine")
    item_4 = create(:random_item, name: "So Many Socks")
    item_5 = create(:random_item, name: "Pants")
    item_6 = create(:random_item, name: "Watches")
    item_7 = create(:random_item, name: "Long Bottles")
    visit "/"

    within 'nav' do
      expect(page).to have_content("Search")
      fill_in :search, with: "Socks"
      click_on "Search"
    end
    expect(current_path).to eq(search_index_path)
  end
end
