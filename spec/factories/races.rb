FactoryBot.define do
  factory :race do
    sequence(:id)
    start { Faker::Time.backward }
    sequence(:day_number)
    name { Faker::Name.name }
    sequence(:round)
    course { %w[東京 中山 京都][Faker::Number.within(range: 0..2)] }
    course_type { Race.course_types.keys.sample }
    distance { Faker::Number.number }
    turn { Race.turns.keys.sample }
    side { Race.sides.keys.sample }
    regulation1 { Faker::Name.name }
    regulation2 { Faker::Name.name }
    regulation3 { Faker::Name.name }
    regulation4 { Faker::Name.name }
    prize1 { Faker::Number.number }
    prize2 { Faker::Number.number }
    prize3 { Faker::Number.number }
    prize4 { Faker::Number.number }
    prize5 { Faker::Number.number }

    trait :with_race_horses do
      6.times do
        after(:create) do |race|
          horse = create(:horse)
          create(:race_horse, horse: horse, race: race)
        end
      end
    end
  end
end
