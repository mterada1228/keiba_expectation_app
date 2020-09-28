FactoryGirl.define do
  factory :horse do
    id { Faker::Number.number(digits: 10) }
  end
end
