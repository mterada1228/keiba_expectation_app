class ChangeDataRaceIdAndHorseIdToRaceHorse < ActiveRecord::Migration[6.0]
  def change
    change_column :race_horses, :race_id, :bigint
    change_column :race_horses, :horse_id, :bigint
  end
end
