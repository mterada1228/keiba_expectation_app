class ChangeDatatypeToHorseRaceResults < ActiveRecord::Migration[6.0]
  def change
    change_column :horse_race_results, :horse_id, :integer
    change_column :horse_race_results, :gate_num, :integer
    change_column :horse_race_results, :horse_number, :integer
    change_column :horse_race_results, :odds, :float
    change_column :horse_race_results, :popularity, :integer
    change_column :horse_race_results, :burden_weight, :float
    change_column :horse_race_results, :time_diff, :integer
    change_column :horse_race_results, :last_3f, :float
    change_column :horse_race_results, :horse_weight, :integer
    change_column :horse_race_results, :difference_in_horse_weight, :integer
    change_column :horse_race_results, :last_3f, :float
    change_column :horse_race_results, :get_prize, :float
  end
end
