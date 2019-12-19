require 'rails_helper'

describe "user navigation" do
  it "restricts access to visitors" do
    visit "/merchant"
    expect(page.status_code).to eq(404)

    visit "/admin"
    expect(page.status_code).to eq(404)

    visit "/profile"
    expect(page.status_code).to eq(404)
  end

  it "restricts users from accessing /merchant and /admin" do
    user = create(:regular_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/merchant"
    expect(page.status_code).to eq(404)

    visit "/admin"
    expect(page.status_code).to eq(404)
  end
end