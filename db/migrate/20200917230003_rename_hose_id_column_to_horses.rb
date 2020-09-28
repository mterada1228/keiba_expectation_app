class RenameHoseIdColumnToHorses < ActiveRecord::Migration[6.0]
  def change
    rename_column :horses, :hose_id, :id
  end
end