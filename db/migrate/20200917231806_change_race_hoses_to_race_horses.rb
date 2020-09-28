class ChangeRaceHosesToRaceHorses < ActiveRecord::Migration[6.0]
  def change
    rename_table :race_hoses, :race_horses
  end
end
