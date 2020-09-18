class RenameHoseIdColumnToHorseRaceResult < ActiveRecord::Migration[6.0]
  def change
    rename_column :hose_race_results, :hose_id, :horse_id
  end
end
