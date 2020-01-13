require 'rails_helper'

describe "merchant coupon code page" do
  it "allows merchants to see coupons" do
    jomah = create(:jomah_merchant)
    ray = create(:ray_merchant)
    coupon_1 = Coupon.create(name: "Fab20", merchant: jomah, amount: 20)
    coupon_2 = Coupon.create(name: "NewYear5", merchant: ray, amount: 5)
  visit "/merchants/#{jomah.id}"
  click_link("My Shop Coupons")
  expect(current_path).to eq("/merchants/#{jomah.id}/coupons")
  expect(page).to have_link(coupon_1.name)
  expect(page).not_to have_link(coupon_2.name)
  end
end
