FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    key { "MyString" }
    user_type { 1 }
    store { nil }
  end
end
