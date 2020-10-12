FactoryBot.define do
  factory :race_result do
    sequence(:id) { |n| n * 12 }
  end
end
