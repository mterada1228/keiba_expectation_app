#
# Horse Model
#
class Horse < ApplicationRecord
  has_many :horse_race_results
  has_many :race_horses
  # TODO
  ## race_horse は廃止。horse_race_result は horse_race に修正して統一する
  has_many :races, through: :horse_race_results
  # has_many :races, through: :race_horses
end
