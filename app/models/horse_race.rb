#
# HorseRace Model
#
class HorseRace < ApplicationRecord
  self.primary_keys = :horse_id, :race_id
  belongs_to :horse
  belongs_to :race

  enum reason_of_exclusion: { pull_up: 0, scratch: 1, withdrawn: 2 }

  scope :first_place_horse_races, -> { where(order_of_arrival: 1) }
  scope :second_place_horse_races, -> { where(order_of_arrival: 2) }
  scope :third_place_horse_races, -> { where(order_of_arrival: 3) }
  scope :unplaced_horse_races, -> { where(arel_table[:order_of_arrival].gt(4)) }
end
