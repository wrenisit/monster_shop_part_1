require 'rails_helper'

describe "coupons at checkout" do
  it "allows coupons to be used" do
    jomah = create(:jomah_merchant)
    coupon_1 = Coupon.create(name: "Fab20", merchant: jomah, amount: 20)
    coupon_2 = Coupon.create(name: "NewYear5", merchant: jomah, amount: 5)
    bill = create(:regular_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(bill)
    item_1 = create(:random_item, merchant: jomah, inventory: 10)
    item_2 = create(:random_item, merchant: jomah, inventory: 5)

    visit "/items/#{item_1.id}"
    click_on "Add To Cart"
    visit "/items/#{item_2.id}"
    click_on "Add To Cart"

    visit "/cart"
    click_button("Add Coupon")
    expect(current_path).to eq("/coupons/new")
    fill_in :name, with: coupon_2.name
    click_button("Submit")
    expect(current_path).to eq("/cart/#{coupon_2.id}")
    expect(page).to have_content("NewYear5")
    expect(page).to have_content("5% Off")
    click_button("Add Coupon")
    expect(current_path).to eq("/coupons/new")
    fill_in :name, with: coupon_1.name
    click_button("Submit")
    expect(current_path).to eq("/cart/#{coupon_1.id}")
    click_on "Checkout"
  end
end
