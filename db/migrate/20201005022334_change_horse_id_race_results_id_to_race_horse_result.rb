class ChangeHorseIdRaceResultsIdToRaceHorseResult < ActiveRecord::Migration[6.0]
  def change
    execute 'ALTER TABLE horse_race_results ADD PRIMARY KEY (horse_id, race_result_id);'
  end
end
