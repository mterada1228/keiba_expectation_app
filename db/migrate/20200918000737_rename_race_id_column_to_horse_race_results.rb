class RenameRaceIdColumnToHorseRaceResults < ActiveRecord::Migration[6.0]
  def change
    rename_column :horse_race_results, :race_id, :race_result_id 
  end
end
