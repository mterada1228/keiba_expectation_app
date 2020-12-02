class AddNotNullContraintToCourseTypeAndTurnToRaces < ActiveRecord::Migration[6.0]
  def change
    change_column_null :races, :course_type, false, 0
    change_column_null :races, :turn, false, 0
  end
end
