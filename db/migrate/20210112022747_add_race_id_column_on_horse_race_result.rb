class AddRaceIdColumnOnHorseRaceResult < ActiveRecord::Migration[6.0]
  def change
    add_reference :horse_race_results, :race, foreign_key: true, after: :horse_id
  end
end
