class RemoveIdFromRaceHorses < ActiveRecord::Migration[6.0]
  def change
    remove_column :race_horses, :id
  end
end
