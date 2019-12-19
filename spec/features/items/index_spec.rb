require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
      @muzzle = @brian.items.create(name: "Duck Muzzle", description: "Quiet your dog with this duck muzzle!", price: 25, image: "https://images-na.ssl-images-amazon.com/images/I/51IoHDEFe4L.jpg", active?:false, inventory: 56)
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
      expect(page).to have_link(@dog_bone.name)
      expect(page).to have_link(@dog_bone.merchant.name)
    end

    it "I can see a list of all of the items "do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

      within "#item-#{@dog_bone.id}" do
        expect(page).to have_link(@dog_bone.name)
        expect(page).to have_content(@dog_bone.description)
        expect(page).to have_content("Price: $#{@dog_bone.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@dog_bone.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@dog_bone.image}']")
      end
    end

    it "can't see deactivated items" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
      expect(page).to have_link(@dog_bone.name)
      expect(page).to have_link(@dog_bone.merchant.name)

      expect(page).to_not have_content(@muzzle.name)
    end

    it "can list top 5 most popular items and quantity bought" do
        order_1 = create(:random_order)
        order_2 = create(:random_order)

        dog_toy = create(:random_item)
        mug = create(:random_item)
        boot = create(:random_item)
        shirt = create(:random_item)
        hat = create(:random_item)
        cookie = create(:random_item)
        pants = create(:random_item)

        ItemOrder.create(item: dog_toy, order: order_1, price: dog_toy.price, quantity: 9)
        ItemOrder.create(item: dog_toy, order: order_2, price: dog_toy.price, quantity: 2)
        ItemOrder.create(item: dog_toy, order: order_2, price: dog_toy.price, quantity: 1)

        ItemOrder.create(item: cookie, order: order_1, price: cookie.price, quantity: 7)
        ItemOrder.create(item: cookie, order: order_2, price: cookie.price, quantity: 3)

        ItemOrder.create(item: pants, order: order_2, price: pants.price, quantity: 8)
        ItemOrder.create(item: mug, order: order_1, price: mug.price, quantity: 5)
        ItemOrder.create(item: boot, order: order_1, price: boot.price, quantity: 4)
        ItemOrder.create(item: shirt, order: order_2, price: shirt.price, quantity: 2)
        ItemOrder.create(item: hat, order: order_2, price: hat.price, quantity: 1)

      visit '/items'

      within "#top_five" do
        expect(page).to have_content(dog_toy.name)
        expect(page).to have_content("Quantity: 12")
      end
      within "#top_five" do
        expect(page).to have_content(cookie.name)
        expect(page).to have_content("Quantity: 10")
      end
      within "#top_five" do
        expect(page).to have_content(pants.name)
        expect(page).to have_content("Quantity: 8")
      end
      within "#top_five" do
        expect(page).to have_content(mug.name)
        expect(page).to have_content("Quantity: 5")
      end
      within "#top_five" do
        expect(page).to have_content(boot.name)
        expect(page).to have_content("Quantity: 4")
      end

      within "#top_five" do
        expect(page).to_not have_content(shirt.name)
      end

      within "#top_five" do
        expect(page).to_not have_content(hat.name)
      end
    end

    it "can list 5 least most popular items and quantity bought  " do
      order_1 = create(:random_order)
      order_2 = create(:random_order)

      dog_toy = create(:random_item)
      mug = create(:random_item)
      boot = create(:random_item)
      shirt = create(:random_item)
      hat = create(:random_item)
      cookie = create(:random_item)
      pants = create(:random_item)

      ItemOrder.create(item: dog_toy, order: order_1, price: dog_toy.price, quantity: 9)
      ItemOrder.create(item: dog_toy, order: order_2, price: dog_toy.price, quantity: 2)
      ItemOrder.create(item: dog_toy, order: order_2, price: dog_toy.price, quantity: 1)

      ItemOrder.create(item: cookie, order: order_1, price: cookie.price, quantity: 7)
      ItemOrder.create(item: cookie, order: order_2, price: cookie.price, quantity: 3)

      ItemOrder.create(item: pants, order: order_2, price: pants.price, quantity: 8)
      ItemOrder.create(item: mug, order: order_1, price: mug.price, quantity: 5)
      ItemOrder.create(item: boot, order: order_1, price: boot.price, quantity: 4)
      ItemOrder.create(item: shirt, order: order_2, price: shirt.price, quantity: 2)
      ItemOrder.create(item: hat, order: order_2, price: hat.price, quantity: 1)

    visit '/items'

    within "#bottom_five" do
      expect(page).to have_content(hat.name)
      expect(page).to have_content("Quantity: 1")
    end
    within "#bottom_five" do
      expect(page).to have_content(shirt.name)
      expect(page).to have_content("Quantity: 2")
    end
    within "#bottom_five" do
      expect(page).to have_content(boot.name)
      expect(page).to have_content("Quantity: 4")
    end
    within "#bottom_five" do
      expect(page).to have_content(mug.name)
      expect(page).to have_content("Quantity: 5")
    end
    within "#bottom_five" do
      expect(page).to have_content(pants.name)
      expect(page).to have_content("Quantity: 8")
    end

    within "#bottom_five" do
      expect(page).to_not have_content(cookie.name)
      expect(page).to_not have_content("Quantity: 10")
    end

    within "#bottom_five" do
      expect(page).to_not have_content(dog_toy.name)
      expect(page).to_not have_content("Quantity: 12")
    end
    end
  end
end
