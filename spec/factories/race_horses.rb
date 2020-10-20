FactoryBot.define do
  factory :race_horse do
    race
    horse
    sequence(:gate_num) { |n| n }
    sequence(:horse_number) { |n| n }
  end
end
