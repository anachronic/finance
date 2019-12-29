FactoryBot.define do
  factory :account do
    user
    name { Faker::Bank.name }
  end
end
