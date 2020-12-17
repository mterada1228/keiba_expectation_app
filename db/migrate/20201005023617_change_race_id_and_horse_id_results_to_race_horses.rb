class ChangeRaceIdAndHorseIdResultsToRaceHorses < ActiveRecord::Migration[6.0]
  def change
    execute 'ALTER TABLE race_horses ADD PRIMARY KEY (race_id, horse_id);'
  end
end
