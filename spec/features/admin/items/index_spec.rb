require 'rails_helper'

RSpec.describe "As an admin user" do
  before :each do
    @merchant = create(:jomah_merchant)
    @admin = create(:admin_user)
    @items = create_list(:random_item, 5, merchant: @merchant)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  describe "the merchant items index page" do
    it 'has the ability to activate and deactivate items' do
      visit "/admin/merchants/#{@merchant.id}/items"
      save_and_open_page
      @items.each do |item|
        within "#item-#{item.id}" do
          expect(page).to have_link "Deactivate"
        end
      end
    end
  end
end