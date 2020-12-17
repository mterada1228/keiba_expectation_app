FactoryBot.define do
  factory :horse do
    sequence(:id)
    name { Faker::Name.name }

    trait :with_horse_race_results do
      6.times do
        after(:create) do |horse|
          create(:horse_race_result, horse: horse)
        end
      end
    end
  end
end
