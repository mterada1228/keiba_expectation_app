FactoryBot.define do
  factory :race_prize do
    sequence(:order_of_arrival)
    sequence(:prize)
  end
end
