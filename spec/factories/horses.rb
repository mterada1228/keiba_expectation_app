FactoryBot.define do
  factory :horse do
    sequence(:id)
    name { Faker::Name.name }

    trait :with_horse_races do
      6.times do
        after(:create) do |horse|
          create(:horse_race, horse: horse)
        end
      end
    end
  end
end
