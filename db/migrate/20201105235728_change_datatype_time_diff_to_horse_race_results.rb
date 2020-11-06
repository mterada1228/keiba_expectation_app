class ChangeDatatypeTimeDiffToHorseRaceResults < ActiveRecord::Migration[6.0]
  def change
    change_column :horse_race_results, :time_diff, :float
  end
end
