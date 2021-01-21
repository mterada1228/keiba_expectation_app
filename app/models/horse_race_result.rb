#
# HorseRaceResult Model
#
class HorseRaceResult < ApplicationRecord
  self.primary_keys = :horse_id, :race_id
  belongs_to :horse
  belongs_to :race

  enum reason_of_exclusion: { pull_up: 0, scratch: 1, withdrawn: 2 }
end
