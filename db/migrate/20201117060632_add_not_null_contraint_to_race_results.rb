class AddNotNullContraintToRaceResults < ActiveRecord::Migration[6.0]
  def change
    change_column_null :race_results, :name, false, 0
    change_column_null :race_results, :course_id, false, 0
    change_column_null :race_results, :course_length, false, 0
    change_column_null :race_results, :date, false, 0
    change_column_null :race_results, :course_type, false, 0
    change_column_null :race_results, :course_condition, false, 0
    change_column_null :race_results, :horse_all_number, false, 0
  end
end
