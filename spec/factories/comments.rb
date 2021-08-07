FactoryBot.define do
  factory :comment do
    description { Faker::String.random(length: 999) }
    user_name { Faker::Name.initials(number: 29) }
    position { Comment.positions.keys.sample }
  end
end
