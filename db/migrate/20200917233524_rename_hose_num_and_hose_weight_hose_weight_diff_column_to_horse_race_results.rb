class RenameHoseNumAndHoseWeightHoseWeightDiffColumnToHorseRaceResults < ActiveRecord::Migration[6.0]
  def change
    rename_column :horse_race_results, :hose_num, :horse_number 
    rename_column :horse_race_results, :hose_weight, :horse_weight
    rename_column :horse_race_results, :hose_weight_diff, :difference_in_horse_weight 
  end
end
