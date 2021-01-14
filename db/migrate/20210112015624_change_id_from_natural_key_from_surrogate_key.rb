class ChangeIdFromNaturalKeyFromSurrogateKey < ActiveRecord::Migration[6.0]
  def change
    reversible do |change|
      change.up do
        remove_reference :horse_race_results, :race_result, index: true
        execute 'ALTER TABLE race_results DROP PRIMARY KEY'
        remove_column :race_results, :id
        add_column :race_results, :id, :primary_key, unsigned: true, first: true
      end

      change.down do
        add_column :race_results, :id, :primary_key
        add_reference :race_results, :id, index: true
      end
    end
  end
end
