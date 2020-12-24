#
# Race Model
#
class Race < ApplicationRecord
  has_many :race_horses
  has_many :horses, through: :race_horses
  has_many :race_regulations
  has_many :race_prizes

  enum course: {
    sapporo: 1, hakodate: 2, fukushima: 3, niigata: 4, tokyo: 5,
    nakayama: 6, cyuukyou: 7, kyouto: 8, hanshin: 9, kokura: 10 }
  enum grade: { g1: 0, g2: 1, g3: 2, Listed: 3, op: 4, three_wins: 5, two_wins: 6, one_win: 7 }
  enum course_type: { turf: 0, dirt: 1, hundle_race: 2 }
  enum turn: { right: 0, left: 1, straight: 2 }
  enum side: { inner_course: 0, external_course: 1 }

  COURSE_TYPE_TRANSLATIONS = {
    '芝' => Race.course_types[:turf],
    'ダ' => Race.course_types[:dirt],
    '障' => Race.course_types[:hundle_race]
  }.freeze

  TURN_TRANSLATIONS = {
    '右' => Race.turns[:right],
    '左' => Race.turns[:right],
    '直線' => Race.turns[:straight]
  }.freeze

  SIDE_TRANSLATIONS = {
    '内' => Race.sides[:inner_course],
    '外' => Race.sides[:external_course]
  }.freeze
end
