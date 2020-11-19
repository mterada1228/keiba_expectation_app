class RenameLastHalfAve3ToGateLastHalfAve3FToRaceResults < ActiveRecord::Migration[6.0]
  def change
    rename_column :race_results, :last_half_ave_3, :last_half_ave_3F
  end
end
