require 'rails_helper'

# As a merchant
# When I visit my items page
# I see a button or link to delete the item next to each item that has never been ordered
# When I click on the "delete" button or link for an item
# I am returned to my items page
# I see a flash message indicating this item is now deleted
# I no longer see this item on the page

RSpec.describe 'merchant item delete', type: :feature do
  describe 'when I visit an merchant items show page' do
    it 'I can delete a merchants item' do
      merchant = create(:jomah_merchant)
      merchant_employee = create(:merchant_employee, merchant: merchant)

      chain = create(:random_item, name: "chain", merchant: merchant)
      tire = create(:random_item, merchant: merchant)
      roof_rack = create(:random_item, merchant: merchant)
      boots = create(:random_item, merchant: merchant)
      sled = create(:random_item, merchant: merchant)
      skis = create(:random_item, merchant: merchant)
      items = [chain, tire, roof_rack, boots, sled]

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_employee)

      visit merchant_dash_items_path

        within "#item-#{chain.id}" do
          expect(page).to have_content(chain.name)
          expect(page).to have_link("Delete Item")
          click_on "Delete Item"
          expect(current_path).to eq(merchant_dash_items_path)
        end
        within "#item-#{roof_rack.id}" do
          expect(page).to have_content(roof_rack.name)
          expect(page).to have_link("Delete Item")
          click_on "Delete Item"
          expect(current_path).to eq(merchant_dash_items_path)
        end
        within "#item-#{boots.id}" do
          expect(page).to have_content(boots.name)
          expect(page).to have_link("Delete Item")
          click_on "Delete Item"
          expect(current_path).to eq(merchant_dash_items_path)
        end

      expect(page).to_not have_content(chain.name)
      expect(page).to have_content(skis.name)
      expect(page).to_not have_content(roof_rack.name)
      expect(page).to_not have_content(boots.name)
      expect(page).to have_content(sled.name)
      expect(page).to have_content(tire.name)
      expect(page).to have_content("Item Deleted")
    end

    xit 'I can delete items and it deletes reviews' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      review_1 = chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)

      visit "/items/#{chain.id}"

      click_on "Delete Item"
      expect(Review.where(id:review_1.id)).to be_empty
    end

    xit 'I can not delete items with orders' do
      user = create(:regular_user)
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      review_1 = chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      order_1 = user.orders.create!(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218)
      order_1.item_orders.create!(item: chain, price: chain.price, quantity: 2)

      visit "/items/#{chain.id}"

      expect(page).to_not have_link("Delete Item")
    end
  end
end
