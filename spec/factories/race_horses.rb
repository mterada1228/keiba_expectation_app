FactoryBot.define do
  factory :race_horse do
    race
    horse
    sequence(:gate_number)
    sequence(:horse_number)
  end
end
