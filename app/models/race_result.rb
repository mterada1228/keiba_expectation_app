class RaceResult < ApplicationRecord
  has_many :horse_race_results

  enum course_type: { turf: 0, dirt: 1, hundle_race: 2 }
  enum course_condition: { firm: 0, good: 1, yielding: 2, soft: 3 }
end
