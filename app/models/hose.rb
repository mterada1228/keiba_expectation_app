class Hose < ApplicationRecord
    has_many :hoseRaceResults
    has_many :race_hose
end
