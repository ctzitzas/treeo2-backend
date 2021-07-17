FactoryBot.define do
  factory :store do
    name { "Corner Store Network" }
    address { "42 Regent Street" }
    suburb { "Oakleigh" }
    state { "Victoria" }
    postcode { "Australia" }
  end
end
