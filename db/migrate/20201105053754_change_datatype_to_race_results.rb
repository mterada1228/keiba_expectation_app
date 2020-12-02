class ChangeDatatypeToRaceResults < ActiveRecord::Migration[6.0]
  def change
    change_column :race_results, :cource_id, :integer
    change_column :race_results, :cource_length, :integer
    change_column :race_results, :prize, :float
    change_column :race_results, :horse_all_number, :integer
  end
end
