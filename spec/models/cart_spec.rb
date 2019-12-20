require "rails_helper"

RSpec.describe Cart do
  describe "methods" do
    before :each do
      @session = Hash.new(0)
      @session[:cart] = 0
      @cart ||= Cart.new(@session)
      @item = create(:random_item)
    end
    it "can initialize with contents" do
      expect(@cart.contents[:cart]).to eq(0)
    end

    it "can add items to content" do
      @cart.add_item(@item.id.to_s)
      expect(@cart.contents[@item.id.to_s]).to eq(1)
    end

    xit "can count total_items" do
    end

    xit "can find a total item quantity" do
    end

    xit "can total a cart items contents" do
    end

    xit "can total a cart's contents" do
    end

    xit "add additional items to cart" do

    end

    xit "can subtract item quantity from cart" do
    end

    xit "can see if a cart's item quantity is more than inventory total" do
    end

    xit "can set cart contents to zero" do
    end
  end
end
