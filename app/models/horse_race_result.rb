#
# HorseRaceResult Model
#
class HorseRaceResult < ApplicationRecord
  belongs_to :horse
  belongs_to :race_result
end
