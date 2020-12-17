class RemoveNullContraintFromOrderOfArrivalsToHorseRaceResults < ActiveRecord::Migration[6.0]
  def change
    change_column_null :races, :course_type, false, 0
    change_column_null :horse_race_results, :order_of_arrival, true
  end
end
