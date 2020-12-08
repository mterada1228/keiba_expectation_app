class AddColumnReasonOfExclusionsToHorseRaceResults < ActiveRecord::Migration[6.0]
  def change
    add_column :horse_race_results, :reason_of_exclusion, :integer, after: :get_prize
  end
end
