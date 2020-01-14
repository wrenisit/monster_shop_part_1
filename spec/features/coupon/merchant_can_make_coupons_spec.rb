require 'rails_helper'

describe "merchant coupon code page" do
  it "allows merchants to see coupons" do
    jomah = create(:jomah_merchant)
    ray = create(:ray_merchant)
    merchant_employee = create(:merchant_employee, merchant: jomah)
    coupon_1 = Coupon.create(name: "Fab20", merchant: jomah, amount: 20)
    coupon_2 = Coupon.create(name: "NewYear5", merchant: ray, amount: 5)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_employee)

  visit "/merchant"
  click_link("My Shop Coupons")
  expect(current_path).to eq("/merchant/coupons")
  expect(page).to have_link(coupon_1.name)
  expect(page).not_to have_link(coupon_2.name)
  click_link("#{coupon_1.name}")
  expect(current_path).to eq("/merchant/coupons/#{coupon_1.id}")

  end
  it "can allow merchant to add coupon" do
    jomah = create(:jomah_merchant)
    ray = create(:ray_merchant)
    merchant_employee = create(:merchant_employee, merchant: jomah)
    coupon_1 = Coupon.create(name: "Fab20", merchant: jomah, amount: 20)
    coupon_2 = Coupon.create(name: "NewYear5", merchant: ray, amount: 5)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_employee)

    visit "/merchant/coupons"
    click_link("Add Coupon")
    expect(current_path).to eq("/merchant/coupons/new")

    fill_in "name", with: "HouseGoods"
    fill_in "amount", with: 10
    click_button("Submit")
    expect(current_path).to eq("/merchant/coupons")
    expect(page).to have_link("HouseGoods")
  end

  it "can allow a merchant to delete a coupon" do
  jomah = create(:jomah_merchant)
  merchant_employee = create(:merchant_employee, merchant: jomah)
  coupon_1 = Coupon.create(name: "Fab20", merchant: jomah, amount: 20)
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_employee)

  visit "/merchant/coupons/#{coupon_1.id}"
  click_button("Delete Coupon")
  expect(current_path).to eq("/merchant/coupons")
  expect(page).not_to have_link(coupon_1.name)
  end

  it "can't allow a merchant to delete a coupon if used" do
    jomah = create(:jomah_merchant)
    merchant_employee = create(:merchant_employee, merchant: jomah)
    coupon_1 = Coupon.create(name: "Fab20", merchant: jomah, amount: 20, used: true)
    coupon_2 = Coupon.create(name: "NewYear5", merchant: jomah, amount: 5)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_employee)

    visit "/merchant/coupons/#{coupon_1.id}"
    click_button("Disable Coupon")
    expect(current_path).to eq("/merchant/coupons")
    expect(page).to have_content(coupon_1.name)
    visit "/merchant/coupons/#{coupon_2.id}"
    expect(page).to have_button("Delete Coupon")
  end
end
