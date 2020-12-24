class RaceResult < ApplicationRecord
  has_many :horse_race_results

  enum course_id: {
    sapporo: 1, hakodate: 2, fukushima: 3, niigata: 4, tokyo: 5,
    nakayama: 6, cyuukyou: 7, kyouto: 8, hanshin: 9, kokura: 10 }
  enum course_type: { turf: 0, dirt: 1, hundle_race: 2 }
  enum course_condition: { firm: 0, good: 1, yielding: 2, soft: 3 }

  COURSE_TYPE_TRANSLATIONS = {
    '芝' => RaceResult.course_types[:turf],
    'ダ' => RaceResult.course_types[:dirt],
    '障' => RaceResult.course_types[:hundle_race]
  }.freeze

  COURSE_CONDITION_TRANSLATIONS = {
    '良' => RaceResult.course_conditions[:firm],
    '稍重' => RaceResult.course_conditions[:good],
    '重' => RaceResult.course_conditions[:yielding],
    '不良' => RaceResult.course_conditions[:soft]
  }.freeze
end
