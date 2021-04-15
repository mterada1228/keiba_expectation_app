#
# Horse Model
#
class Horse < ApplicationRecord
  has_many :horse_races
  has_many :races, through: :horse_races
  has_many :race_results, through: :races
end
