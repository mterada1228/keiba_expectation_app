class ChangeDatatypeIdFromBigintToStringOnRace < ActiveRecord::Migration[6.0]
  def up
    remove_reference :horse_race_results, :race
    remove_reference :race_prizes, :race
    remove_reference :race_regulations, :race
    remove_reference :race_results, :race
    change_column :races, :id, :string
    add_reference :horse_race_results, :race, type: :string, after: :horse_id
    add_reference :race_prizes, :race, type: :string, after: :id
    add_reference :race_regulations, :race, type: :string, after: :id
    add_reference :race_results, :race, type: :string, after: :id
  end

  def down
    remove_reference :horse_race_results, :race
    remove_reference :race_prizes, :race
    remove_reference :race_regulations, :race
    remove_reference :race_results, :race
    change_column :races, :id, :integer
    add_reference :horse_race_results, :race, after: :horse_id
    add_reference :race_prizes, :race, after: :id
    add_reference :race_regulations, :race, after: :id
    add_reference :race_results, :race, after: :id
  end
end
