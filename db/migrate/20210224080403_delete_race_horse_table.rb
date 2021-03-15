class DeleteRaceHorseTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :race_hoses
  end
end
