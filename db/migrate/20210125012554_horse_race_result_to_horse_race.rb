class HorseRaceResultToHorseRace < ActiveRecord::Migration[6.0]
  def change
    rename_table :horse_race_results, :horse_races
  end
end
