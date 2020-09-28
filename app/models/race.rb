#
# Race Model
#
class Race < ApplicationRecord
  has_many :race_horses

  self.primary_key = :id

  def race_horses_sorted_by_horse_number
    race_horses.sort do |a, b|
      a[:horse_number].to_i <=> b[:horse_number].to_i
    end
  end
end
