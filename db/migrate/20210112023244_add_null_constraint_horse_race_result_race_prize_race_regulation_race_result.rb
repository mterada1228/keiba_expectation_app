class AddNullConstraintHorseRaceResultRacePrizeRaceRegulationRaceResult < ActiveRecord::Migration[6.0]
  def change
    change_column_null :horse_race_results, :race_id, false, 0
    change_column_null :race_prizes, :race_id, false, 0
    change_column_null :race_regulations, :race_id, false, 0
    change_column_null :race_results, :race_id, false, 0
  end
end
