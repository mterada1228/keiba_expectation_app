class ChangeDatatypeToRaceHorses < ActiveRecord::Migration[6.0]
  def change
    change_column :race_horses, :gate_num, :integer
    change_column :race_horses, :horse_number, :integer
  end
end
