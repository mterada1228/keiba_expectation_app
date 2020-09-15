class Hose < ApplicationRecord
    has_many :hoseRaceResults
    has_many :raceHoses
end
