class RemoveDefaultValueFromRaces < ActiveRecord::Migration[6.0]
  def change
    change_column_default :races, :course_type, from: 0, to: nil
    change_column_default :races, :turn, from: 0, to: nil
    change_column_default :races, :side, from: 0, to: nil
  end
end

