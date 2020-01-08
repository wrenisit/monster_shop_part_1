require 'rails_helper'

RSpec.describe "As an admin user" do
  before :each do
    @merchant = create(:jomah_merchant)
    @admin = create(:admin_user)
    @item_1 = create(:random_item, merchant: @merchant)
    @item_2 = create(:random_item, merchant: @merchant)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  describe "the merchant items index page" do
    it 'has the ability to activate and deactivate items' do
      visit "/admin/merchants/#{@merchant.id}/items"
      within "#item-#{@item_1.id}" do
        click_link "Deactivate"
      end

      within "#item-#{@item_1.id}" do
        expect(page).to have_link "Activate"
      end
    end

    it 'has the ability to add an item' do
      visit "/admin/merchants/#{@merchant.id}/items"
      expect(page).to have_link "Add New Item"
    end

    it 'has the ability to delete/edit items' do
      visit "/admin/merchants/#{@merchant.id}/items"
    end
  end
end