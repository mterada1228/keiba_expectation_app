class ChangeDatatypeIdToRaceResults < ActiveRecord::Migration[6.0]
  def change
    change_column :race_results, :id, :string
  end
end
