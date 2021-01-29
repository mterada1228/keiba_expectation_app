class ChangePrimaryKeyFromHorseAndRaceResultIdToId < ActiveRecord::Migration[6.0]
  def change
    reversible do |change|
      change.up do
        execute 'ALTER TABLE horse_race_results DROP PRIMARY KEY'
      end

      change.down do
        execute 'ALTER TABLE horse_race_results ADD PRIMARY KEY (horse_id, race_result_id)'
      end
    end
    add_column :horse_race_results, :id, :primary_key, unsigned: true, first: true
    add_foreign_key :horse_race_results, :horses
    add_foreign_key :horse_race_results, :race_results
  end
end
