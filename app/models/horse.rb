#
# Horse Model
#
class Horse < ApplicationRecord
  has_many :horse_race_results
  has_many :race_horses

  self.primary_key = :id
end
