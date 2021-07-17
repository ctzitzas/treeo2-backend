FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.free_email }
    password_digest { Faker::Internet.password(min_length: 8) }
    key { Faker::Alphanumeric.alphanumeric(number: 10) }
    user_type { 1 }
    store { association :store }
  end
end
