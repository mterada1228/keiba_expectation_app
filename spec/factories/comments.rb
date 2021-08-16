FactoryBot.define do
  factory :comment do
    description { Faker::String.random(length: 999) }
    user_name { Faker::Name.name[0..29] }
    comment_type { Comment.comment_types.keys.sample }
  end
end
