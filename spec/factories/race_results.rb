FactoryBot.define do
  factory :race_result do
    sequence(:id)
    name { Faker::Name.name }
    sequence(:course_id)
    sequence(:course_length)
    date { Faker::Date.backward }
    course_type { RaceResult.course_types.keys.sample }
    course_condition { RaceResult.course_conditions.keys.sample }
    RPCI { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    ave_1F { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    sequence(:horse_all_number)
  end
end
