#
# Race Model
#
class Race < ApplicationRecord
  has_many :horse_races
  has_many :horses, through: :horse_races
  has_many :race_regulations
  has_many :race_prizes

  # TODO 海外, 地方の競馬場が必要になった時にここに追加する
  enum course: {
    sapporo:  1, hakodate: 2, fukushima: 3, niigata: 4, tokyo: 5,
    nakayama: 6, cyuukyou: 7, kyouto: 8, hanshin: 9, kokura: 10,
    longchamp: 38, ooi: 44
  }
  enum grade: { g1: 0, g2: 1, g3: 2, listed: 3, op: 4, three_wins: 5, two_wins: 6, one_win: 7 }
  enum course_type: { turf: 0, dirt: 1, hundle_race: 2 }
  enum turn: { right: 0, left: 1, straight: 2 }
  enum side: { inner_course: 0, external_course: 1 }
  enum course_condition: { firm: 0, good: 1, yielding: 2, soft: 3 }

  scope :races_by_condition, ->(condition) { where(course_condition: condition) }
  scope :first_place_horse_races, lambda {
    joins(:horse_races).merge(HorseRace.first_place_horse_races)
  }
  scope :second_place_horse_races, lambda {
    joins(:horse_races).merge(HorseRace.second_place_horse_races)
  }
  scope :third_place_horse_races, lambda {
    joins(:horse_races).merge(HorseRace.third_place_horse_races)
  }
  scope :unplaced_horse_races, -> { joins(:horse_races).merge(HorseRace.unplaced_horse_races) }

  COURSE_TRANSLATIONS = {
    '01' => Race.courses[:sapporo],
    '02' => Race.courses[:hakodate],
    '03' => Race.courses[:fukushima],
    '04' => Race.courses[:niigata],
    '05' => Race.courses[:tokyo],
    '06' => Race.courses[:nakayama],
    '07' => Race.courses[:cyuukyou],
    '08' => Race.courses[:kyouto],
    '09' => Race.courses[:hanshin],
    '10' => Race.courses[:kokura],
    'C8' => Race.courses[:longchamp],
    '44' => Race.courses[:ooi]
  }.freeze

  COURSE_TYPE_TRANSLATIONS = {
    '芝' => Race.course_types[:turf],
    'ダ' => Race.course_types[:dirt],
    '障' => Race.course_types[:hundle_race]
  }.freeze

  TURN_TRANSLATIONS = {
    '右' => Race.turns[:right],
    '左' => Race.turns[:left],
    '直線' => Race.turns[:straight]
  }.freeze

  SIDE_TRANSLATIONS = {
    '内' => Race.sides[:inner_course],
    '外' => Race.sides[:external_course]
  }.freeze

  COURSE_CONDITION_TRANSLATIONS = {
    '良' => Race.course_conditions[:firm],
    '稍' => Race.course_conditions[:good],
    '稍重' => Race.course_conditions[:good],
    '重' => Race.course_conditions[:yielding],
    '不' => Race.course_conditions[:soft],
    '不良' => Race.course_conditions[:soft]
  }.freeze
end
