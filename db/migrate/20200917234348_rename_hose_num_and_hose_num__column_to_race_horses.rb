class RenameHoseNumAndHoseNumColumnToRaceHorses < ActiveRecord::Migration[6.0]
  def change
    rename_column :race_horses, :hose_num, :horse_number 
  end
end
