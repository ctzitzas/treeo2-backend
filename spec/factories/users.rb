FactoryBot.define do
  factory :user do
    name { "Chris" }
    email { "ctzitzas@me.com" }
    password_digest { "password" }
    key { "AAA001" }
    user_type { 1 }
    store { association :store }
  end
end
