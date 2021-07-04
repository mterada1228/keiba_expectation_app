FactoryBot.define do
  factory :horse_race do
    horse
    race
    sequence(:order_of_arrival)
    burden_weight { Faker::Number.decimal }
    time { Faker::Time.backward }

    trait :won_race do
      order_of_arrival { 1 }
    end

    trait :race_lost_by_0_point_2_seconds do
      order_of_arrival { 2 }
      time_diff { 0.2 }
    end

    trait :race_lost_by_1_second do
      order_of_arrival { 2 }
      time_diff { 1.0 }
    end

    trait :race_lost_by_more_than_1_second do
      order_of_arrival { 2 }
      time_diff { 1.1 }
    end
  end
end
