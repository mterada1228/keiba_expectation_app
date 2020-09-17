class RenameHoseIdColumnToRaceHoses < ActiveRecord::Migration[6.0]
  def change
    rename_column :race_hoses, :hose_id, :horse_id
  end
end
