require 'rails_helper'
RSpec.describe "admin mechant show page" do
  it "sees everything that merchant would see" do
     user = create(:admin_user) 
     ray = create(:ray_merchant)

     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

     visit "/merchants"

     click_on "#{ray.name}"
     expect(current_path).to eq("/admin/merchants/#{ray.id}")
     expect(page).to have_content(ray.name)
     expect(page).to have_content(ray.address)
     expect(page).to have_content(ray.city)
     expect(page).to have_content(ray.state)
     expect(page).to have_content(ray.zip)
     expect(page).to have_link("All #{ray.name} Items")
     expect(page).to have_content("Number of Items: #{ray.item_count}")
  end
end
