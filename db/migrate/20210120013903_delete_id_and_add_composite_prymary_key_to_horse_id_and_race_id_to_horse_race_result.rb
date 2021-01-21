class DeleteIdAndAddCompositePrymaryKeyToHorseIdAndRaceIdToHorseRaceResult < ActiveRecord::Migration[6.0]
  def up
    execute 'ALTER TABLE horse_race_results CHANGE COLUMN `id` `id` int(10) unsigned NOT NULL ;'
    execute 'ALTER TABLE horse_race_results DROP PRIMARY KEY'
    remove_column :horse_race_results, :id
    execute 'ALTER TABLE horse_race_results ADD PRIMARY KEY(horse_id, race_id)'
  end

  def down
    execute 'ALTER TABLE horse_race_results DROP PRIMARY KEY'
    add_column :horse_race_results, :id, :primary_key, unsigned: true, first: true
  end
end
