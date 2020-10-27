FactoryBot.define do
  factory :race_result do
    sequence(:id) { |n| n }
    name { Faker::Name.name }
    RPCI { Faker::Number.decimal }
    ave_1F { Faker::Number.decimal }
  end
end
