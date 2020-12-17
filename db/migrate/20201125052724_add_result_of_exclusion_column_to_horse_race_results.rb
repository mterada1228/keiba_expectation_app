class AddResultOfExclusionColumnToHorseRaceResults < ActiveRecord::Migration[6.0]
  def up
    add_column :horse_race_results, :reason_of_exclusion, :integer, after: :get_prize
  end

  def down
    remove_column :horse_race_results, :reason_of_exclusion
  end
end
