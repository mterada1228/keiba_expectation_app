#
# HorseRaceResult Model
#
class HorseRaceResult < ApplicationRecord
  belongs_to :horse
  belongs_to :race_result

  enum reason_of_exclusion: { pull_up: 0, scratch: 1, withdrawn: 2 }
end
