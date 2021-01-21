class AddForeignKeyHorseIdOnHorseRaceResult < ActiveRecord::Migration[6.0]
  def up
    remove_foreign_key :horse_race_results, :horses
    execute 'ALTER TABLE horse_race_results DROP PRIMARY KEY'
    remove_column :horse_race_results, :horse_id
    add_reference :horse_race_results, :horse, foreign_key: true, first: true
    execute 'ALTER TABLE horse_race_results ADD PRIMARY KEY(horse_id, race_id)'
  end

  def down
    remove_foreign_key :horse_race_results, :horses
    execute 'ALTER TABLE horse_race_results DROP PRIMARY KEY'
    remove_column :horse_race_results, :horse_id
    add_reference :horse_race_results, :horse, first: true
    execute 'ALTER TABLE horse_race_results ADD PRIMARY KEY(horse_id, race_id)'
  end
end
