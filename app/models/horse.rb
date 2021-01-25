#
# Horse Model
#
class Horse < ApplicationRecord
  has_many :horse_races
  has_many :races, through: :horse_races
end
