class RenameGateNumToGateNumberToRaceHorses < ActiveRecord::Migration[6.0]
  def change
    rename_column :race_horses, :gate_num, :gate_number
  end
end
