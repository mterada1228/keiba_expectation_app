class RenameHoseAllNumberColumnToRaceResults < ActiveRecord::Migration[6.0]
  def change
    rename_column :race_results, :hose_all_number, :horse_all_number 
  end
end
