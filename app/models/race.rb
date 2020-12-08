#
# Race Model
#
class Race < ApplicationRecord
  has_many :race_horses
  has_many :horses, through: :race_horses

  enum course_type: { turf: 0, dirt: 1, hundle_race: 2 }
  enum turn: { right: 0, left: 1, straight: 2 }
  enum side: { inner_course: 0, external_course: 1 }
end
