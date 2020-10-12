FactoryGirl.define do
  factory :horse_race_result do
    association :horse
    association :race_result
  end
end
