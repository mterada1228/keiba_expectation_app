class RenameRaceIdColumnToRaces < ActiveRecord::Migration[6.0]
  def change
    rename_column :races, :race_id, :id 
  end
end
