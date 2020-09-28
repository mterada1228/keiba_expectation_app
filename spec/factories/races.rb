FactoryGirl.define do
  factory :race do
    id { Faker::Number.number(digits: 12) }
  end
end
