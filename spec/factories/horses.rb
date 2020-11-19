FactoryBot.define do
  factory :horse do
    sequence(:id)
    name { Faker::Name.name }
  end
end
