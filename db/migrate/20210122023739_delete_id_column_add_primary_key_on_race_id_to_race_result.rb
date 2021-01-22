class DeleteIdColumnAddPrimaryKeyOnRaceIdToRaceResult < ActiveRecord::Migration[6.0]
  def up
    execute 'ALTER TABLE race_results CHANGE COLUMN `id` `id` int(10) unsigned NOT NULL ;'
    execute 'ALTER TABLE race_results DROP PRIMARY KEY'
    remove_column :race_results, :id
    execute 'ALTER TABLE race_results ADD PRIMARY KEY (race_id)'
  end

  def down
    execute 'ALTER TABLE race_results DROP PRIMARY KEY'
    add_column :race_results, :id, :primary_key, unsigned: true, first: true
  end
end
