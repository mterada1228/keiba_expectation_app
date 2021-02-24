class RaceResult < ApplicationRecord
  belongs_to :race

  enum course_condition: { firm: 0, good: 1, yielding: 2, soft: 3 }


  COURSE_CONDITION_TRANSLATIONS = {
    '良' => RaceResult.course_conditions[:firm],
    '稍' => RaceResult.course_conditions[:good],
    '稍重' => RaceResult.course_conditions[:good],
    '重' => RaceResult.course_conditions[:yielding],
    '不' => RaceResult.course_conditions[:soft],
    '不良' => RaceResult.course_conditions[:soft]
  }.freeze
end
