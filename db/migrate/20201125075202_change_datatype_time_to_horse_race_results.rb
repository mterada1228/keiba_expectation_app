class ChangeDatatypeTimeToHorseRaceResults < ActiveRecord::Migration[6.0]
  def change
    change_column :horse_race_results, :time, :time, limit: 3
  end
end
