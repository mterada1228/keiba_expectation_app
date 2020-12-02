class RenameGateNumToGateNumberToHorseRaceResults < ActiveRecord::Migration[6.0]
  def change
    rename_column :horse_race_results, :gate_num, :gate_number
  end
end
