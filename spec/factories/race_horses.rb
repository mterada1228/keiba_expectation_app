FactoryGirl.define do
  factory :race_horse do
    association :race
    association :horse
  end
end
