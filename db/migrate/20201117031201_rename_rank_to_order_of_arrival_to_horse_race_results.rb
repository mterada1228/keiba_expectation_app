class RenameRankToOrderOfArrivalToHorseRaceResults < ActiveRecord::Migration[6.0]
  def change
    rename_column :horse_race_results, :rank, :order_of_arrival
  end
end
