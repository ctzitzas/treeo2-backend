FactoryBot.define do
  factory :purchase do
    receipt_url { "MyString" }
    payment_intent_id { "MyString" }
    user { nil }
  end
end
