class RemoveNullContraintFromTurnToRaces < ActiveRecord::Migration[6.0]
  def change
    change_column_null :races, :turn, true
  end
end
