FactoryBot.define do
  factory :race_result do
    course_condition { RaceResult.course_conditions.keys.sample }
    RPCI { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    ave_1F { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    sequence(:horse_all_number)
  end
end
