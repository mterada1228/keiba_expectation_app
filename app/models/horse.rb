class Horse < ApplicationRecord
    has_many :horse_race_results
    has_many :race_horses
end
