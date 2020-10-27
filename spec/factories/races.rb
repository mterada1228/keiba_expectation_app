FactoryBot.define do
  factory :race do
    sequence(:id)
    race_date { formatted_race_date }
    sequence(:days)
    start_time { formatted_race_time }
    race_name { Faker::Name.name }
    sequence(:round)
    race_cource { %w[東京 中山 京都][Faker::Number.within(range: 0..2)] }
    cource_type { Race.cource_types.keys.sample }
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

def formatted_race_date
  date = Faker::Date.in_date_period
  formatted_date = date.strftime('%-m月%-d日')
  day_of_week = %w[日 月 火 水 木 金 土][date.wday]
  "#{formatted_date}(#{day_of_week})"
end

def formatted_race_time
  time = Faker::Time.backward
  time.strftime('%M:%S')
end
