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
end