FactoryBot.define do
  factory :race_result do
    sequence(:id)
    name { Faker::Name.name }
    sequence(:course_id)
    sequence(:course_length)
    date { Faker::Date.backward }
    course_type { RaceResult.course_types.keys.sample }
    course_condition { RaceResult.course_conditions.keys.sample }
    RPCI { Faker::Number.decimal }
    ave_1F { Faker::Number.decimal }
    sequence(:horse_all_number)
  end
end
