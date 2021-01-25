FactoryBot.define do
  factory :race do
    sequence(:id)
    start { Faker::Time.backward }
    sequence(:day_number)
    name { Faker::Name.name }
    sequence(:round)
    course { Race.courses.values.sample }
    course_type { Race.course_types.values.sample }
    sequence(:distance)
    turn { Race.turns.values.sample }
    side { Race.sides.values .sample }

    trait :with_horse_races do
      6.times do
        after(:create) do |race|
          horse = create(:horse)
          create(:horse_race, horse: horse, race: race)
        end
      end
    end
  end
end
