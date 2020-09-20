class HoseRaceResultToHorseRaceResult < ActiveRecord::Migration[6.0]
  def change
    rename_table :hose_race_results, :horse_race_results
  end
end
