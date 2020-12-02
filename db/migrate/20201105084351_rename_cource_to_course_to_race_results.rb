class RenameCourceToCourseToRaceResults < ActiveRecord::Migration[6.0]
  def change
    rename_column :race_results, :cource_id, :course_id
    rename_column :race_results, :cource_length, :course_length
    rename_column :race_results, :cource_type, :course_type
    rename_column :race_results, :cource_condition, :course_condition
  end
end
