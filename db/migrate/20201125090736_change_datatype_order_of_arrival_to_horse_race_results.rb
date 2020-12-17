class ChangeDatatypeOrderOfArrivalToHorseRaceResults < ActiveRecord::Migration[6.0]
  def change
    change_column :horse_race_results, :order_of_arrival, :integer
  end
end
