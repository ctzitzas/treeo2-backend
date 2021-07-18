FactoryBot.define do
  factory :store do
    name { Faker::Restaurant.name   }
    address { Faker::Address.street_address }
    suburb { Faker::Address.city }
    state { Faker::Address.state }
    postcode { "Australia" }
  end
end
