#
# Race Model
#
class Race < ApplicationRecord
  has_many :race_horses

  self.primary_key = :id
end
