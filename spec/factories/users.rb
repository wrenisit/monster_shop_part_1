FactoryBot.define do
  factory :random_user, class: User do
    name      {Faker::FunnyName.name}
    address   {Faker::Address.street_address}
    city      {Faker::Address.city}
    state     {Faker::Address.state_abbr}
    zip       {12345}
    email     {Faker::Internet.email}
    password  {"password123"}
    password_confirmation  {"password123"}
  end


   factory :regular_user, class: User do
    name      {"Bruce Wayne"}
    address   {"123 Midway Ave"}
    city      {"Gotham"}
    state     {"IL"}
    zip       {53540}
    email     {"imbatman@bat.com"}
    password  {"robinsucks"}
    password_confirmation  {"robinsucks"}
  end

   factory :admin_user, class: User do
    name      {"Barry Allen"}
    address   {"800 S Star St"}
    city      {"Central City"}
    state     {"FL"}
    zip       {32013}
    email     {"fastestmanalive@yaboo.com"}
    password  {"imfast1"}
    password_confirmation  {"imfast1"}
   end

  factory :merchant_user, class: User do
    name      {"Diana Prince"}
    address   {"456 Super Ln"}
    city      {"New Youk City"}
    state     {"NY"}
    zip       {34533}
    email     {"hailhydra@redskullmaiil.com"}
    password  {"america!1"}
    password_confirmation  {"america!1"}
   end

  factory :merchant_admin_user, class: User do
    name      {"Clark Kent"}
    address   {"1938 Sullivan Lane"}
    city      {"Smallville"}
    state     {"KS"}
    zip       {87603}
    email     {"abird@dmail.com"}
    password  {"krypto2"}
    password_confirmation  {"krypto2"}
   end
end

