FactoryBot.define do
  factory :race do
    sequence(:id)
    start { Faker::Time.backward }
    sequence(:day_number)
    name { Faker::Name.name }
    sequence(:round)
    course { %w[東京 中山 京都][Faker::Number.within(range: 0..2)] }
    course_type { Race.course_types.keys.sample }
    sequence(:distance)
    turn { Race.turns.keys.sample }
    side { Race.sides.keys.sample }
    regulation1 { Faker::Name.name }
    regulation2 { Faker::Name.name }
    regulation3 { Faker::Name.name }
    regulation4 { Faker::Name.name }
    prize1 { Faker::Number.decimal(l_digits: 2) }
    prize2 { Faker::Number.decimal(l_digits: 2) }
    prize3 { Faker::Number.decimal(l_digits: 2) }
    prize4 { Faker::Number.decimal(l_digits: 2) }
    prize5 { Faker::Number.decimal(l_digits: 2) }

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
