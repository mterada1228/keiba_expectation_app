#
# Horse Model
#
class Horse < ApplicationRecord
  has_many :horse_race_results
  has_many :race_horses
  has_many :race_results, through: :horse_race_results

  self.primary_key = :id
end
