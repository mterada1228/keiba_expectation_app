FactoryBot.define do
  factory :horse do
    sequence(:id) { |n| n }
    name { Faker::Name.name }
  end
end
