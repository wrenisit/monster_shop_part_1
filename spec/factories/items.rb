FactoryBot.define do
  factory :random_item, class: Item do
    sequence(:name)   {|n| "#{Faker::Commerce.product_name} #{n}"}
    description       {Faker::Lorem.sentence}
    price             {rand(1..100)}
    image             {|n| "http://lorempixel.com/400/300/abstract/#{n}"}
    active?           {true}
    inventory         {rand(1..100)}
    association       :merchant, factory: :jomah_merchant
  end
end
