FactoryBot.define do
  factory :race_regulation do
    regulation { RaceRegulation.regulations.values.sample }
  end
end
