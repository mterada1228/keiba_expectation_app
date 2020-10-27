#
# Horse Model
#
class Horse < ApplicationRecord
  has_many :horse_race_results
  has_many :race_horses
  has_many :race_results, :through => :horse_race_results

  # TODO feature-add-rspec を merge したら以下の primary key の指定は不要
  self.primary_key = :id
end
