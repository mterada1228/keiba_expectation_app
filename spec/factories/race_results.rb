FactoryBot.define do
  factory :race_result do
    sequence(:id)
    name { Faker::Name.name }
    RPCI { Faker::Number.decimal }
    ave_1F { Faker::Number.decimal }
  end
end
