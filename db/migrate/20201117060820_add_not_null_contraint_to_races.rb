class AddNotNullContraintToRaces < ActiveRecord::Migration[6.0]
  def change
    change_column_null :races, :start, false, 0
    change_column_null :races, :course, false, 0
    change_column_null :races, :round, false, 0
    change_column_null :races, :name, false, 0
    change_column_null :races, :distance, false, 0
  end
end
