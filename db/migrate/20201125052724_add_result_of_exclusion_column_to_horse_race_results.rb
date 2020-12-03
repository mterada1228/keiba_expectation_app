class AddResultOfExclusionColumnToHorseRaceResults < ActiveRecord::Migration[6.0]
  def up
    add_column :horse_race_results, :reason_of_exclusion, :integer, default: 0
  end

  def down
    remove_column :horse_race_results, :reason_of_exclusion, :integer, default: 0
  end
end
