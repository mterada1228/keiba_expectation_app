class ChangeDatatypeSideAndTurnOfRace < ActiveRecord::Migration[6.0]
  def change
    change_column :races, :side, :integer
    change_column :races, :turn, :integer
  end
end
