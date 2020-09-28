class RaceHose < ApplicationRecord
  belongs_to :hose, foreign_key: 'hose_id', class_name: 'Hose'
  belongs_to :race, foreign_key: 'race_id', class_name: 'Race'
end
