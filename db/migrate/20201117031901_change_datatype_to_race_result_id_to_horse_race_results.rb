class ChangeDatatypeToRaceResultIdToHorseRaceResults < ActiveRecord::Migration[6.0]
  def change
    change_column :horse_race_results, :horse_id, :bigint
  end
end
