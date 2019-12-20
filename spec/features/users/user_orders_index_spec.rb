require 'rails_helper'

RSpec.describe "profile orders index page" do
  it "has a index of orders for user" do
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @regular_user = User.create(name: "Boo",
                               address: "123 Main",
                               city: "Broomfield",
                               state: "CO",
                               zip: 80020,
                               email: "gooble@foogle.com",
                               password: "notsecure123")
     visit '/'
     click_on 'Log In'
     expect(current_path).to eq("/login")
     fill_in :email, with: "gooble@foogle.com"
     fill_in :password, with: "notsecure123"
     click_button "Log In"

     @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
     @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
     @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
     @order = @regular_user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
     @order.item_orders.create!(item: @paper, price: @paper.price, quantity: 2)
     @order.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 3)
     visit "/profile"
     click_link "My Orders"
     expect(current_path).to eq("/profile/orders")

     within "#order-#{@order.id}"
     expect(page).to have_link("#{@order.id}")
     expect(page).to have_content(@order.created_at)
     expect(page).to have_content(@order.updated_at)
     expect(page).to have_content(@order.count)
     expect(page).to have_content(@order.total)
     expect(page).to have_content(@order.status)
  end
end

# As a registered user
# When I visit my Profile Orders page, "/profile/orders"
# I see every order I've made, which includes the following information:
#
# the ID of the order, which is a link to the order show page
# the date the order was made
# the date the order was last updated
# the current status of the order
# the total quantity of items in the order
# the grand total of all items for that order
