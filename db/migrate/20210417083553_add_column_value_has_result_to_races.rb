class AddColumnValueHasResultToRaces < ActiveRecord::Migration[6.0]
  def change
    change_column_default :races, :has_result, from: nil, to: false
  end
end
