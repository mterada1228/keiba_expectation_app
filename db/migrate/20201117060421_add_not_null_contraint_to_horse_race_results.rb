class AddNotNullContraintToHorseRaceResults < ActiveRecord::Migration[6.0]
  def change
    change_column_null :horse_race_results, :order_of_arrival, false, 0
    change_column_null :horse_race_results, :burden_weight, false, 0
  end
end
