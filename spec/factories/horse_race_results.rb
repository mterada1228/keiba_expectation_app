FactoryBot.define do
  factory :horse_race_result do
  end

  trait :won_race do
    rank { '1' }
  end

  trait :race_lost_by_0_point_2_seconds do
    rank { '2' }
    time_diff { 0.2 }
  end

  trait :race_lost_by_1_second do
    rank { '2' }
    time_diff { 1.0 }
  end

  trait :race_lost_by_more_than_1_second do
    rank { '2' }
    time_diff { 1.1 }
  end
end
